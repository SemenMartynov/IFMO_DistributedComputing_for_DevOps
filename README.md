# Развертывание WordPress с помощью Docker и Ansible
Этот проект предоставляет плейбук Ansible для развертывания приложения WordPress с использованием Docker, при этом база данных работает в отдельном контейнере.

## Структура проекта
```
IFMO_DistributedComputing_for_DevOps
├── group_vars
│   └── all.yml
├── host_vars
│   └── localhost.yml
├── roles
│   ├── docker
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── docker-compose.yml.j2
│   ├── wordpress
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── wp-config.php.j2
│   └── db
│       ├── tasks
│       │   └── main.yml
│       └── templates
│           └── db-config.yml.j2
├── inventory
│   └── hosts.ini
├── playbook.yml
└── README.md
```

## Требования
- Любой современный дистрибутив Linux
- Ansible [core 2.18.3] или новее
- Docker Compose version v2.31.0-desktop.2 или новее
- Docker version 27.4.0 или новее

# Инструкции по настройке
1. Клонируйте этот репозиторий на свой локальный компьютер.
2. Перейдите в каталог проекта:
   ``` bash
   cd IFMO_DistributedComputing_for_DevOps
   ```
3. Обновите файл `group_vars/all.yml` с вашими учетными данными базы данных и настройками WordPress.
4. Измените файл `host_vars/localhost.yml`, если у вас есть какие-либо специфические конфигурации для вашей локальной среды.
5. Убедитесь, что ваш файл инвентаря (`inventory/hosts.ini`) правильно настроен для указания на целевые хосты.
6. Создайте сеть Docker:
   ``` bash
   docker network create wordpress-network
   ```
7. Запустите плейбук:
   ``` bash
   sudo ansible-playbook -i inventory/hosts.ini playbook.yml
   ```

## Использование
После запуска плейбука у вас должен быть сайт WordPress, работающий на Docker, доступный по IP-адресу вашей хост-машины. Вы можете управлять контейнерами с помощью команд Docker.

![image](https://github.com/AlexeyKuzko/IFMO_DistributedComputing_for_DevOps/blob/main/result.png)