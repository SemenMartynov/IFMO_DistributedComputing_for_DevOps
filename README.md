# IFMO_DistributedComputing_for_DevOps

## Автоматизированное развёртывание отказоустойчивой инфраструктуры WordPress с MySQL репликацией, Galera Cluster и системой мониторинга

Проект по дисциплине «Распределённые вычисления» (ИТМО) для поэтапного развёртывания высокодоступной веб-инфраструктуры с использованием Ansible, Docker Compose, MySQL GTID-репликации, MariaDB Galera Cluster и комплексного мониторинга.

## Архитектура решения

### Развёртываемые компоненты

| Компонент | Описание | Порты |
|-----------|----------|-------|
| **WordPress** | PHP-FPM приложение с Nginx | 8080:80 |
| **MySQL Master** | Основной сервер БД с GTID | Внутренняя сеть |
| **MySQL Slaves** | Две реплики для чтения | Внутренняя сеть |
| **Galera Cluster** | 5-узловой кластер MariaDB | 3306:3306 (HAProxy) |
| **HAProxy** | Балансировщик нагрузки | 3306:3306, 8404:8404 |
| **cAdvisor** | Мониторинг контейнеров | 8081:8080 |
| **Prometheus** | Сбор и хранение метрик | 9091:9090 |
| **Grafana** | Визуализация метрик | 3000:3000 |

### Особенности реализации

- **Поэтапное развёртывание** через 4 независимых плейбука
- **MySQL 8.4.4 GTID-репликация** для автоматического failover
- **MariaDB Galera Cluster** с синхронной репликацией
- **HAProxy** для балансировки нагрузки между узлами
- **Комплексный мониторинг** с готовыми дашбордами
- **Автоматическая миграция** данных между кластерами
- **Health-check** проверки для всех сервисов

## Предварительные требования

### Системные требования

- **Целевой сервер**: Ubuntu 24.04 LTS
- **Контрольная машина**: Ubuntu 20.04+
- **Python**: 3.8 или выше
- **Оперативная память**: минимум 8 GB
- **Дисковое пространство**: минимум 20 GB

### Сетевые требования

- Доступные порты: 22 (SSH), 3000, 3306, 8080, 8081, 8404, 9091, 9101
- Стабильное интернет-соединение для загрузки Docker-образов

## Установка и настройка окружения

### 1. Клонирование репозитория

```bash
$ git clone https://github.com/DmitryFedoroff/IFMO_DistributedComputing_for_DevOps.git
$ cd IFMO_DistributedComputing_for_DevOps
```

### 2. Установка SSH Pass

```bash
$ sudo apt install sshpass
```

### 3. Настройка Ansible

#### Обновление системных пакетов

```bash
$ sudo apt update && sudo apt upgrade -y
```

#### Установка системных зависимостей

```bash
$ sudo apt install python3 python3-pip python3-venv git curl
```

#### Создание виртуального окружения

```bash
$ python3 -m venv ~/.venvs/ansible
```

#### Активация виртуального окружения

```bash
$ source ~/.venvs/ansible/bin/activate
```

#### Установка Ansible

```bash
$ pip install --upgrade pip
$ pip install ansible
```

#### Установка зависимостей Ansible Galaxy

```bash
$ ansible-galaxy collection install -r requirements.yml --force
```

### 4. Настройка Ansible Lint

#### Создание локального окружения проекта

```bash
$ python3 -m venv .venv
$ source .venv/bin/activate
```

#### Установка Ansible Lint

```bash
$ pip install ansible ansible-lint
$ .venv/bin/ansible-lint --version
```

#### Настройка VS Code

Откройте папку проекта в VS Code и в выпадающем меню Python Interpreter выберите:
```
.venv/bin/python     Workspace
```

## Структура проекта

```
IFMO_DistributedComputing_for_DevOps/
├── ansible.cfg                    # Конфигурация Ansible
├── inventory.yml                  # Инвентарь хостов
├── requirements.yml               # Зависимости Ansible Galaxy
├── group_vars/
│   └── all.yml                   # Глобальные переменные
├── roles/                        # Ansible роли
│   ├── docker_setup/             # Установка Docker и базовая конфигурация
│   ├── db_setup/                 # Настройка MySQL master-slave репликации
│   ├── wordpress_setup/          # Развёртывание WordPress
│   ├── cadvisor/                 # Мониторинг контейнеров
│   ├── prometheus/               # Сбор метрик
│   ├── grafana/                  # Визуализация метрик
│   └── galera_cluster/           # 5-узловой Galera кластер
├── playbook1.yml                 # Домашнее задание №1
├── playbook2.yml                 # Домашнее задание №2
├── playbook3.yml                 # Домашнее задание №3
└── playbook4.yml                 # Домашнее задание №4
```

## Описание плейбуков

### playbook1.yml
Развёртывает базовую инфраструктуру Docker, WordPress с PHP-FPM/Nginx и MySQL кластер из трёх узлов (master + 2 slaves).

### playbook2.yml
Настраивает GTID-репликацию между MySQL master и slave серверами с автоматической миграцией данных и валидацией репликации.

### playbook3.yml
Устанавливает систему мониторинга на базе cAdvisor, Prometheus и Grafana с готовыми дашбордами для визуализации метрик.

### playbook4.yml
Развёртывает 5-узловой MariaDB Galera Cluster с HAProxy балансировщиком.

## Последовательный запуск плейбуков

### Выполнение домашних заданий по порядку

```bash
# Активация виртуального окружения Ansible
$ source ~/.venvs/ansible/bin/activate

# Домашнее задание №1: Базовая инфраструктура
$ ansible-playbook playbook1.yml -vvv

# Домашнее задание №2: MySQL репликация
$ ansible-playbook playbook2.yml -vvv

# Домашнее задание №3: Система мониторинга
$ ansible-playbook playbook3.yml -vvv

# Домашнее задание №4: Galera Cluster
$ ansible-playbook playbook4.yml -vvv
```

## Конфигурация компонентов

### Основные переменные (group_vars/all.yml)

```yaml
# WordPress
is_wordpress: true
wordpress_port: 8080
wordpress_db_name: wordpress_db
wordpress_admin_user: admin
wordpress_admin_password: admin_password

# MySQL/MariaDB
db_root_password: root_password
database_user: wordpress_user
database_password: wordpress_password

# Репликация
replication_user: repl
replication_password: replication_password

# Мониторинг
cadvisor_port: 8081
prometheus_port: 9091
grafana_port: 3000

# Galera Cluster
db1_host: galera_node_1
db2_host: galera_node_2
db3_host: galera_node_3
db4_host: galera_node_4
db5_host: galera_node_5

# HAProxy
loadbalancer: haproxy
haproxy_port: 3306
```

### Docker-тома для персистентности данных

- MySQL Master/Slave: `mysql_master_data`, `mysql_slave1_data`, `mysql_slave2_data`
- Galera Cluster: `galera_data_node_1` ... `galera_data_node_5`
- WordPress: `wordpress_data`
- Prometheus: `/opt/prometheus`
- Grafana: `/opt/grafana`

## Управление инфраструктурой

### Перезапуск отдельных компонентов

```bash
# WordPress
$ docker restart wordpress_app wordpress_nginx

# MySQL репликация
$ docker restart mysql_master mysql_slave1 mysql_slave2

# Galera Cluster
$ docker restart galera_node_1 galera_node_2 galera_node_3 galera_node_4 galera_node_5

# Мониторинг
$ docker restart prometheus grafana cadvisor
```

### Просмотр логов

```bash
# Все контейнеры
$ docker ps -a

# Логи конкретного сервиса
$ docker logs -f wordpress_app
$ docker logs -f mysql_master
$ docker logs -f galera_node_1
```

### Проверка статуса репликации

```bash
# MySQL Master-Slave
$ docker exec -it mysql_master mysql -u root -proot_password -e "SHOW MASTER STATUS\G"
$ docker exec -it mysql_slave1 mysql -u root -proot_password -e "SHOW REPLICA STATUS\G"

# Galera Cluster
$ docker exec -it galera_node_1 mysql -u root -proot_password -e "SHOW STATUS LIKE 'wsrep_%'"
```

### Резервное копирование

```bash
# Backup WordPress database
$ docker exec mysql_master mysqldump -u root -proot_password wordpress_db > wordpress_backup.sql

# Backup Galera node
$ docker exec galera_node_1 mysqldump -u root -proot_password --all-databases > galera_backup.sql
```

## Устранение неполадок

### Проблемы с Docker

```bash
# Проверка статуса Docker
$ sudo systemctl status docker

# Перезапуск Docker
$ sudo systemctl restart docker

# Очистка неиспользуемых ресурсов
$ docker system prune -a
```

### Проблемы с репликацией MySQL

```bash
# Сброс репликации на slave
$ docker exec -it mysql_slave1 mysql -u root -proot_password
mysql> STOP REPLICA;
mysql> RESET REPLICA ALL;
mysql> EXIT;

# Повторный запуск playbook2.yml
$ ansible-playbook playbook2.yml -vvv
```

### Проблемы с Galera Cluster

```bash
# Принудительный bootstrap кластера
$ docker stop galera_node_1 galera_node_2 galera_node_3 galera_node_4 galera_node_5
$ docker rm galera_node_1 galera_node_2 galera_node_3 galera_node_4 galera_node_5

# Повторный запуск playbook4.yml
$ ansible-playbook playbook4.yml -vvv
```

### Проблемы с мониторингом

```bash
# Проверка targets в Prometheus
$ curl http://localhost:9091/api/v1/targets

# Перезапуск стека мониторинга
$ docker restart prometheus grafana cadvisor haproxy_exporter
```

### Полная переустановка

```bash
# Остановка всех контейнеров
$ docker stop $(docker ps -aq)

# Удаление всех контейнеров
$ docker rm $(docker ps -aq)

# Удаление всех томов (ВНИМАНИЕ: удалит все данные!)
$ docker volume prune -f

# Запуск всех плейбуков заново
$ ansible-playbook playbook1.yml playbook2.yml playbook3.yml playbook4.yml -vvv
```

## Контакты

- **Автор**: Дмитрий Федоров
- **Эл. почта**: [fedoroffx@gmail.com](mailto:fedoroffx@gmail.com)
- **Telegram**: [https://t.me/dmitryfedoroff](https://t.me/dmitryfedoroff)
