# Развертывание WordPress с помощью Docker и Ansible
Этот проект предоставляет плейбук Ansible для развертывания приложения WordPress с использованием Docker, при этом база данных работает в кластере MySQL с синхронизацией данных.

## Структура проекта
```
IFMO_DistributedComputing_for_DevOps
├── group_vars
│   └── all.yml
├── host_vars
│   └── wordpress.yml
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
- Управляющий сервер (локальный компьютер):
  - Ansible [core 2.18.3] или новее
  - SSH-ключ для доступа к удаленному серверу
- Удаленный сервер:
  - Ubuntu/Debian Linux
  - Минимум 4 ГБ оперативной памяти для работы кластера базы данных
  - Docker и Docker Compose будут установлены автоматически

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
1. Клонируйте этот репозиторий на ваш локальный компьютер:
   ```bash
   git clone https://github.com/AlexeyKuzko/IFMO_DistributedComputing_for_DevOps.git
   ```

2. Перейдите в каталог проекта:
   ```bash
   cd IFMO_DistributedComputing_for_DevOps
   ```

3. Убедитесь, что у вас есть SSH-ключ для доступа к удаленному серверу:
   ```bash
   ls ~/.ssh/distributed_computing/private_key
   ```

4. Обновите файл `group_vars/all.yml` с вашими учетными данными базы данных и настройками WordPress.

5. Запустите плейбук для развертывания на удаленном сервере:
   ```bash
   ansible-playbook -i inventory/hosts.ini playbook.yml
   ```

## Использование
После запуска плейбука у вас будет сайт WordPress, доступный по адресу, указанному в inventory/hosts.ini (например, http://158.160.46.212:8080).

### Проверка состояния кластера
Вы можете управлять контейнерами с помощью команд Docker на удаленном сервере.
Для проверки состояния кластера MySQL вы можете выполнить следующие команды на удаленном сервере:

```bash
# Подключение к первичному узлу
docker exec -it mysql_primary mysql -uroot -proot_password

# Внутри MySQL выполните:
SELECT * FROM performance_schema.replication_group_members;
```