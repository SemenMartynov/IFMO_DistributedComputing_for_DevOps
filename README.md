# ЛР №1: Развёртывание WordPress через Ansible

## Цель работы

Автоматизировать установку Docker и запуск приложения WordPress с базой данных MySQL в отдельных контейнерах на удалённой виртуальной машине с использованием Ansible.

---

## Структура проекта

```bash
inventory.ini             # Inventory-файл с описанием хостов и ключей
playbook.yml              # Основной playbook
files/
└── docker-compose.yml    # Compose-файл для запуска WordPress и MySQL
README.md                 # Описание проекта
```

## Результат работы

В результате работы на удалённой ВМ был установлен Docker, развёрнут Wordpress + MySQL  
#### Логи о выполнении
![alt text](img/lab1/logs.jpg)
#### ```docker ps```
![alt text](img/lab1/docker-ps.png)
#### UI Wordpress на ip удалённой машины
![alt text](img/lab1/wp-ui.png)

# ЛР №2: Развёртывание кластера БД с синхронизацией данных

## Цель работы

Автоматизировать установку Docker и запуск приложения WordPress с базой данных MySQL в отдельных контейнерах на удалённой виртуальной машине с использованием Ansible.

---

## Структура проекта

```bash
inventory.ini             # Inventory-файл с описанием хостов и ключей
playbook.yml              # Основной playbook
files/
└── docker-compose.yml    # Compose-файл для запуска WordPress и MySQL
└── master                # Конфиг для мастера
    └── init.sql          # Init-скрипт для создания бд, пользователя и выдачи прав
    └── my.cnf            # Конфиг мастера mysql
└── replica               # Конфиг для реплики
    └── init.sql          # Init-скрипт для настройки и запуска реплики
    └── my.cnf            # Конфиг реплики mysql
README.md                 # Описание проекта
```

## Результат работы

В результате работы на удалённой ВМ был установлен Docker, развёрнут Wordpress + MySQL  
#### Логи о выполнении
![alt text](img/lab2/logs.png)
#### ```docker ps```
![alt text](img/lab2/docker-ps.png)
#### Скрин настроек реплики
![alt text](img/lab2/replica-cfg-log.png)
#### Скрин синхронизации таблиц
![alt text](img/lab2/sync-tables.png)
