# DevOps Project: WordPress + MySQL (Master/Slave) + Monitoring

## Описание проекта

Данный проект автоматизирует развертывание веб-приложения WordPress с базой данных MySQL (репликация Master-Slave) и системы мониторинга (Prometheus + Grafana) на удалённом сервере под управлением Ubuntu 24.04. Проект реализован с помощью Ansible: установка необходимых компонентов, запуск Docker-контейнеров и настройка выполнены плейбуками и ролями.

После выполнения плейбуков:
- На сервере будет установлен Docker и Docker Compose plugin (если не был установлен).
- Запущен сайт WordPress (PHP + Apache в контейнере) и база данных MySQL. Данные WordPress и БД сохраняются во вне контейнеров (Docker volumes), чтобы обеспечить сохранение состояния.
- Настроена репликация MySQL: реализована схема Master-Slave, где все изменения на мастере автоматически воспроизводятся на реплике.
- Развернут мониторинг: система сбора метрик Prometheus и графический интерфейс Grafana. Grafana по умолчанию доступна на порту 3000 (логин/пароль: admin/admin).

## Требования

- **Целевой сервер:** Ubuntu 24.04 (amd64) с доступом по SSH. Необходимо ~2 ГБ свободной ОЗУ (WordPress, MySQL, Prometheus и Grafana в контейнерах) и ~10 ГБ диска.
- **Контроллер Ansible:** Ansible 2.13+ (или Ansible Core 2.14+) на локальной машине для запуска плейбуков.
- **Права доступа:** Пользователь на целевом сервере с правами на установку пакетов (sudo). В inventory необходимо указать пароль для SSH и пароль для `become`.

Дополнительно, для выполнения некоторых задач требуется коллекции Ansible:
- **community.docker** (для модулей Docker) – установка: `ansible-galaxy collection install community.docker`
- **community.mysql** (для управления MySQL) – установка: `ansible-galaxy collection install community.mysql`

Эти коллекции должны быть установлены перед запуском плейбуков (если Ansible 2.9+, они не входят по умолчанию). Ansible-lint для проверки кода также должен быть свежей версии, если планируется проверять плейбуки на соответствие стилю.

## Настройка

1. Клонируйте репозиторий на вашу машину:

```bash
   git clone https://github.com/muxbyte93/IFMO_DistributedComputing_for_DevOps.git
 ```

2. Перейдите в каталог проекта:
    
    ```bash
    cd IFMO_DistributedComputing_for_DevOps
    ```
    
3. Отредактируйте файл `inventory.yml`, указав параметры вашего сервера:
    
    - IP-адрес или hostname сервера (`ansible_host`).
        
    - Пользователя (`ansible_user`) и пароль (`ansible_password`).
        
    - Пароль для повышения привилегий (`ansible_become_pass`), если требуется.
        
    - При необходимости, измените порт WordPress (`wordpress_port`), пароль MySQL (`mysql_root_password`) или другие переменные. По умолчанию WordPress будет на 80 порту, пароль root MySQL – "somewordpress".
        

## Запуск

Выполните плейбуки последовательно с помощью Ansible:

```bash
# Шаг 1: Установка Docker и запуск WordPress + MySQL
ansible-playbook playbook1.yml

# Шаг 2: Настройка репликации MySQL (master-slave)
ansible-playbook playbook2.yml

# Шаг 3: Развертывание мониторинга (Prometheus и Grafana)
ansible-playbook playbook3.yml
```

При запуске плейбуков требуется соблюдать указанную последовательность. После выполнения каждого плейбука Ansible выведет отладочные сообщения (через `debug`), подтверждающие применённые параметры 