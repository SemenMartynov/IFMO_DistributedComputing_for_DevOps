# Распределенное веб-приложение с мониторингом
Этот проект представляет Ansible‑плейбук для пошагового развертывания WordPress веб-приложения с помощью Docker Compose и подключением мониторинга.
Сначала запускается однобазовая конфигурация. (ДЗ1)
Затем выполняется резервное копирование MySQL и приложение перезапускается в режиме кластера MySQL с включённой групповой репликацией данных. (ДЗ2)
В завершении к существующей системе подключается мониторинг Grafana + Prometheus c автоматическим импортированием шаблона дашборда для мониторинга базы данных. (ДЗ3)

## Структура проекта
```
IFMO_DistributedComputing_for_DevOps
├── group_vars
│   └── all.yml
├── roles
│   ├── homework1
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── docker-compose.yml.j2
│   ├── homework2
│   │   ├── files
│   │   │   └── primary_bootstrap.sql
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── docker-compose.yml.j2
│   ├── homework3
│   │   ├── files
│   │   │   └── dashboard.sql
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── compose-grafana-prometheus.yml.j2
│   │       └── grafana-dashboard.yml.j2
│   │       └── grafana-datasource.yml.j2
│   │       └── prometheus.yml.j2
├── inventory
│   └── hosts.ini
├── playbook.yml
└── README.md
```

## Требования
- Управляющий сервер (локальный компьютер):
  - Ansible [core 2.18.3] или новее
  - Community-плагины для Ansible:
  - * ansible-galaxy collection install community.docker
  - * ansible-galaxy collection install community.mysql
  - SSH-ключ для доступа к удаленному серверу
- Удаленный сервер:
  - Ubuntu/Debian Linux
  - Минимум 4 ГБ оперативной памяти для работы кластера базы данных
  - Docker и Docker Compose будут установлены автоматически

## Архитектура распределенного приложения
Система состоит из следующих компонентов:
- **WordPress**: Веб-приложение, работающее в отдельном контейнере
- **Кластер MySQL**: Три узла MySQL (1 первичный, 2 вторичных) с групповой репликацией
  - **Первичный узел**: Обрабатывает запросы на запись и чтение
  - **Вторичные узлы**: Обрабатывают запросы на чтение и служат резервными копиями
- **Сети Docker**: 
  - `my_app_wordpress-network`: Сеть для WordPress
  - `db_cluster_network`: Сеть для кластера базы данных
- **Система мониторинга**: 
  - ы

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
После запуска плейбука, будет развернуто и запущено WordPress веб-приложение, доступное по URI, указанному в inventory/hosts.ini (например, http://158.160.46.212:8080).
Мониторинг будет доступен по порту, указанному в inventory/hosts.ini (например, http://158.160.46.212:3000).

### Проверка состояния кластера
Вы можете управлять контейнерами с помощью команд Docker на удаленном сервере.
Для проверки состояния кластера MySQL вы можете выполнить следующие команды на удаленном сервере:

```bash
# Подключение ко вторичному узлу
docker exec -it mysql_secondary mysql -uroot -proot_password

# Внутри MySQL выполните:
SHOW REPLICA STATUS;
```
## Завершение работы
Для остановки веб-приложения, выполните:
```bash
sudo docker rm -f $(sudo docker ps -aq) ; sudo docker system prune -a ; sudo docker volume prune
```
Для очистки вольюмов контейнеров, выполните:
```bash
sudo docker volume rm my_app_db_data my_app_wordpress_data my_app_mysql_primary_data my_app_mysql_secondary_data my_app_grafana my_app_prometheus
```
Для очистки конфигурационных файлов, выполните:
```bash
sudo rm -r /opt/my_app
```