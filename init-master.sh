#!/bin/bash

echo "Подключение к MySQL и создание пользователя для репликации..."

mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "
  CREATE USER '$MYSQL_REPLICA_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$MYSQL_REPLICA_PASSWORD';
  GRANT REPLICATION SLAVE ON *.* TO '$MYSQL_REPLICA_USER'@'%';
  FLUSH PRIVILEGES;
  FLUSH TABLES WITH READ LOCK;
"

echo "Пользователь для репликации создан"
