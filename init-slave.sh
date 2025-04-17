#!/bin/bash

echo "Ожидание запуска mysql_master..."

until mysqladmin ping -h "mysql_master" --silent; do
  sleep 2
done

echo "Подключаемся к мастеру..."

log_file=$(mysql -hmysql_master -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW MASTER STATUS\G" | grep File | awk '{print $2}')
log_pos=$(mysql -hmysql_master -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW MASTER STATUS\G" | grep Position | awk '{print $2}')

echo "Настройка репликации..."

mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "
  CHANGE REPLICATION SOURCE TO
    SOURCE_HOST='mysql_master',
    SOURCE_USER='replica',
    SOURCE_PASSWORD='slavepass',
    SOURCE_LOG_FILE='${log_file}',
    SOURCE_LOG_POS=${log_pos};
  START REPLICA;
"

echo "Репликация запущена"
