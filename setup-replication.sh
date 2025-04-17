#!/bin/bash

# Ожидаем запуска мастер-сервера
until docker-compose exec db mysqladmin ping -h localhost -u root -psomewordpress --silent; do
    echo "Ожидание запуска мастер-сервера..."
    sleep 2
done

# Ожидаем запуска реплики
until docker-compose exec db_replica mysqladmin ping -h localhost -u root -psomewordpress --silent; do
    echo "Ожидание запуска реплики..."
    sleep 2
done

# Создаем пользователя для репликации на мастер-сервере
docker-compose exec db mysql -u root -psomewordpress -e "CREATE USER IF NOT EXISTS 'repl_user'@'%' IDENTIFIED BY 'repl_password';"
docker-compose exec db mysql -u root -psomewordpress -e "GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%';"
docker-compose exec db mysql -u root -psomewordpress -e "FLUSH PRIVILEGES;"

# Останавливаем репликацию на слейве
docker-compose exec db_replica mysql -u root -psomewordpress -e "STOP SLAVE;"
docker-compose exec db_replica mysql -u root -psomewordpress -e "RESET SLAVE ALL;"

# Сбрасываем бинарные логи на мастер-сервере
docker-compose exec db mysql -u root -psomewordpress -e "RESET MASTER;"

# Создаем дамп базы данных на мастер-сервере с GTID
docker-compose exec db mysqldump -u root -psomewordpress --all-databases --single-transaction --routines --triggers --events --set-gtid-purged=ON > /tmp/master_dump.sql

# Восстанавливаем дамп на реплике
docker-compose exec -T db_replica mysql -u root -psomewordpress < /tmp/master_dump.sql

# Ожидаем инициализации базы данных WordPress
echo "Ожидание инициализации базы данных WordPress..."
until docker-compose exec db_replica mysql -u root -psomewordpress -e "SHOW TABLES FROM wordpress LIKE 'wp_options'" | grep -q "wp_options"; do
    echo "Ожидание создания таблицы wp_options..."
    sleep 2
done

# Настраиваем реплику с использованием GTID
docker-compose exec db_replica mysql -u root -psomewordpress -e "CHANGE MASTER TO MASTER_HOST='db', MASTER_PORT=3306, MASTER_USER='repl_user', MASTER_PASSWORD='repl_password', MASTER_AUTO_POSITION=1;"
docker-compose exec db_replica mysql -u root -psomewordpress -e "START SLAVE;"

# Ожидаем запуска репликации
sleep 10

# Проверяем статус репликации
echo "Проверка статуса репликации..."
docker-compose exec db_replica mysql -u root -psomewordpress -e "SHOW SLAVE STATUS\G"

# Удаляем временный файл дампа
rm -f /tmp/master_dump.sql

echo "Репликация настроена!" 