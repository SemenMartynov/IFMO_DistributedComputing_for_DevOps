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

Мониторинг реализован для развертывания отдельно от хоста с wordpress и базой, но для проверки можно развернуть все на одном. Для этого в inventory указать один IP для обоих хостов и запустить плейбук с параметром `-t singlehost` для пропуска шагов с копированием сертификатов.

Доступы к prometheus и grafana:

https://monitoring-host-ip:9090/
http://monitoring-host-ip:3000/

**Доработки по заданию 2:**

✅ Вернул vault

✅ Исправил ошибку при повторных запусках, если пользователь уже существует

✅ Пропускаем таски с созданием и восстановлением дампа, если репликация была включена ранее

✅ server_id в vars


## Task 4

**Доработки по заданию 3:**

✅ Добавление экспортеров через Prometheus Scrape Configs вместо blockinfile
✅ Исправлена работа на arm64 
✅ Предустановлены дашборды в Grafana

# Использование

## Активировать виртуальное окружение с установленным ansible

`pyenv activate ansible`

`pip install -r requirements.txt`

## При необходимости добавить ключ для авторизации по ssh

`eval $(ssh-agent)`

`ssh-add ~/.ssh/<файл с ключом>`

## Проверка связи

`ansible all -m ping -i inventory/hosts.yml --ask-vault-pass`

## Vault

Пароль **9900**

## Запуск

Плейбуки запускать последовательно:

`ansible-playbook playbooks/task1.yml -i inventory/hosts.yml --ask-vault-pass`

`ansible-playbook playbooks/task2.yml -i inventory/hosts.yml --ask-vault-pass`

`ansible-playbook playbooks/task3.yml -i inventory/hosts.yml --ask-vault-pass` (для развертывания на одном хосте `ansible-playbook playbooks/task3.yml -i inventory/hosts.yml --ask-vault-pass -t singlehost`)