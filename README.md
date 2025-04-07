# Развертывание WordPress с помощью Docker и Ansible
Этот проект предоставляет плейбук Ansible для развертывания приложения WordPress с использованием Docker, при этом база данных работает в кластере MySQL с синхронизацией данных.

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
│   └── db_cluster
│       ├── tasks
│       │   └── main.yml
│       └── templates
│           └── my.cnf
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
- Минимум 4 ГБ оперативной памяти для работы кластера базы данных

## Архитектура системы
Система состоит из следующих компонентов:
- **WordPress**: Веб-приложение, работающее в отдельном контейнере
- **Кластер MySQL**: Три узла MySQL (1 первичный, 2 вторичных) с групповой репликацией
  - **Первичный узел**: Обрабатывает запросы на запись и чтение
  - **Вторичные узлы**: Обрабатывают запросы на чтение и служат резервными копиями
- **Сети Docker**: 
  - `wordpress-network`: Сеть для WordPress
  - `db_cluster_network`: Сеть для кластера базы данных

# Инструкции по настройке
1. Клонируйте этот репозиторий на целевой сервер.
   ``` bash
   git clone https://github.com/AlexeyKuzko/IFMO_DistributedComputing_for_DevOps.git
   ```
2. Перейдите в каталог проекта:
   ``` bash
   cd IFMO_DistributedComputing_for_DevOps
   ```
3. Обновите файл `group_vars/all.yml` с вашими учетными данными базы данных и настройками WordPress.
4. Измените файл `host_vars/localhost.yml`, если у вас есть какие-либо специфические конфигурации для вашей локальной среды.
5. Убедитесь, что ваш файл инвентаря (`inventory/hosts.ini`) правильно настроен для указания на целевые хосты.
6. Запустите плейбук:
   ``` bash
   sudo ansible-playbook -i inventory/hosts.ini playbook.yml
   ```

## Использование
После запуска плейбука у вас должен быть сайт WordPress, например http://158.160.46.212:8080, работающий на Docker, доступный по IP-адресу вашей хост-машины. Вы можете управлять контейнерами с помощью команд Docker.

### Проверка состояния кластера
Для проверки состояния кластера MySQL вы можете выполнить следующие команды:

```bash
# Подключение к первичному узлу
docker exec -it mysql_primary mysql -uroot -proot_password

# Внутри MySQL выполните:
SELECT * FROM performance_schema.replication_group_members;
```