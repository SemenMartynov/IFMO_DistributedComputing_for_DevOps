# Развертывание WordPress с репликацией MySQL (Master-Slave) через Ansible и Docker

## Введение

Этот проект автоматизирует развёртывание **WordPress** в Docker-контейнерах с настройкой репликации MySQL (Master–Slave) с помощью **Ansible**. 
В плейбук входят все необходимые шаги от установки Плейбук выполняет все необходимые шаги от установки Docker до запуска WordPress и двух экземпляров MySQL (мастер и реплика).

## Требования

- **ОС:** Ubuntu 20.04+ или совместимый Debian-дистрибутив
- **Права:** пользователь с правами `sudo` или `root`
- **SSH:** доступ к целевому серверу
- **Ansible:** версия `ansible-core` или выше
- **Git:** для обновления файлов шаблонов

## Установка Ansible на Ubuntu

```bash
sudo apt update
sudo apt install ansible-core -y
```

## Настройка инвентаря

Создайте файл `inventory.ini` в корне проекта:

```ini
[wordpress]
wp_server ansible_connection={Ip-адрес целевой машины}
```

## Переменные плейбука

| Переменная            | Описание                                              | Пример               |
|-----------------------|-------------------------------------------------------|----------------------|
| `mysql_root_password` | Пароль root MySQL                                     | `my_root_password`   |
| `mysql_database`      | Название базы данных для WordPress                    | `wordpress_db`       |
| `mysql_user`          | Пользователь БД для WordPress                         | `wp_user`            |
| `mysql_password`      | Пароль для `wp_user`                                  | `wp_password`        |
| `docker_network`      | Docker-сеть для связи WordPress и БД                  | `wp_network`         |
| `cluster_network`     | Docker-сеть для связей между мастером и репликой      | `ms_network`         |
| `replica_user`        | Пользователь репликации MySQL                         | `replica_user`       |
| `replica_password`    | Пароль пользователя репликации                        | `password`           |

## Структура проекта

```
├── ans.yml                   # Ansible-плейбук
├── inventory.ini             # Инвентори файл
└── project/                  # Клонируемый репозиторий с шаблонами
    ├── templates/            # Jinja2-шаблоны SQL-конфигураций
    │   ├── user_init_master.sql.j2
    │   └── user_init_slave.sql.j2
    └── sql_confs/            # Генерируемые SQL-файлы
        ├── user_init_master.sql
        └── user_init_slave.sql
```
 
## Запуск плейбука

Если выполняется от root:
```bash
ansible-playbook -i inventory.ini Cluster_mysql_wp.yml
```

Если выполняется от обычного пользователя:

```bash
ansible-playbook -i inventory.ini Cluster_mysql_wp.yml --ask-become-pass
```
Плейбук запросит пароль sudo 


