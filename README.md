# Учебный проект 

Развертывание Wordpress + БД в Docker

# Плейбуки

## Task 1

Развернуть docker с WordPress, вынеся DB в отдельный контейнер.

Включает роли:
- **docker** - устанавливает docker
- **wordpress** - разворачивает wordpress+mariadb через docker compose

## Task 2

Для своего инстанса WordPress, заменить БД на cluster, и обеспечить синхронизацию данных.

Включает роли:
- **wordpress-mysql-replication** - разворачивает wordpress+mariadb+реплику БД через docker compose

## Task 3

Для своего кластера БД настроить мониторинг и алертинг.

Включает роли: 
- **exporter-common** - генерирует ssl-сертификаты для prometheus и экспортеров
- **mysql-exporter** - настраивает экспорт метрик БД
- **node-exporter** - настраивает экспорт метрик хоста
- **prometheus** - настраивает cбор метрик (prometheus), мониторинг доступности сайта (blackbox), алертинг (alertmanager) в Telegram и Grafana с подключенными метриками из prometheus

Необходимо задать переменные окружения *TELEGRAM_BOT_TOKEN* и *TELEGRAM_CHAT_ID* - например, поместить в файл `.env` в корне проекта и выполнить `export $(grep -v '^#' .env | xargs)`

Доступы к prometheus и grafana:

https://monitoring-host-ip:9090/
http://monitoring-host-ip:3000/ (admin:admin)

**Доработки по заданию 2:**

✅ Вернул vault

✅ Исправил ошибку при повторных запусках, если пользователь уже существует

✅ Пропускаем таски с созданием и восстановлением дампа, если репликация была включена ранее

✅ server_id в vars


## Task 4

Реализовать полноценный кластер на базе Galera Cluster (из 5 узлов). Приложение (WordPress) не обязано уметь определять состояние конкретного узла и перебирать подключения, поэтому между приложением и кластером устанавливается балансировщик нагрузки (HAProxy), который определяет "здоровье" узлов кластера и распределяет запросы.

**Доработки по заданию 3:**

✅ Добавление экспортеров через Prometheus Scrape Configs вместо blockinfile

✅ Исправлена работа на arm64 

✅ Предустановлены дашборды в Grafana

**Доработки по заданию 2:**

✅ Снятие и восстановление дампов через модуль mysql_db вместо exec

# Использование

## Активировать виртуальное окружение с установленным ansible

`pyenv activate ansible`

`pip install -r requirements.txt`

## При необходимости добавить ключ для авторизации по ssh

`eval $(ssh-agent)`

`ssh-add ~/.ssh/<файл с ключом>`

## Проверка связи

`ansible all -m ping`

## Vault

Пароль в файле `vault_password.txt`

## Запуск

Плейбуки запускать последовательно:

`ansible-playbook playbook1.yml`

`ansible-playbook playbook2.yml`

`ansible-playbook playbook3.yml`

`ansible-playbook playbook4.yml` 