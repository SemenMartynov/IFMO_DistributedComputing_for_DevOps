CREATE DATABASE IF NOT EXISTS replication_db;

-- Создание пользователя без SSL (важно!)
CREATE USER IF NOT EXISTS 'repl_user'@'%' IDENTIFIED BY 'replpass' REQUIRE NONE;

-- Выдаём права на репликацию
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%';

-- Применяем
FLUSH PRIVILEGES;