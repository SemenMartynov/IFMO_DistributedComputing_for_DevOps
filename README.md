# Лабораторная работа по Ansible

## Описание

Данная лабораторная работа демонстрирует процесс автоматической установки и настройки веб-сервиса WordPress с использованием Ansible. В результате выполнения проекта создаётся инфраструктура, включающая базу данных MariaDB, сервер WordPress и сервер Nginx для работы сайта.

Сайт WordPress будет доступен по адресу: **http://158.160.97.167**

## Структура проекта

Проект состоит из следующих основных компонентов:

- **playbook1.yml** — установка Docker и подготовка окружения.
- **playbook2.yml** — деплой и настройка реплики MariaDB.
- **playbook3.yml** — установка Prometheus, Grafana и cAdvisor для мониторинга.

## Минимальные требования для запуска

### Операционная система

- **Ubuntu 24.04.2 LTS**

### Конфигурация сервера

- Процессор: 2 ядра, 2.2 ГГц
- Оперативная память: 2 ГБ
- Жёсткий диск: 40 ГБ (HDD, RAID)
- Сетевая конфигурация: 1 IP-адрес

## Используемые технологии

- Ansible
- Docker, Docker Compose
- WordPress, Nginx, MariaDB
- Prometheus, Grafana, cAdvisor

## Инструкция по запуску

1. Установите зависимости:
   ```bash
   sudo apt update && sudo apt install ansible
   ```

2. Подготовьте `inventory.yml`.

3. Запустите плейбуки по порядку:
   ```bash
   ansible-playbook playbook1.yml --ask-vault-password -i inventory.yml
   ansible-playbook playbook2.yml --ask-vault-password -i inventory.yml
   ansible-playbook playbook3.yml --ask-vault-password -i inventory.yml
   ```

4. Перейдите в браузере по адресу:
   ```
   http://<vm-ip>
   ```

## Мониторинг

После запуска `playbook3.yml`, система мониторинга будет доступна:

- Grafana: `http://<vm-ip>:9100`

## Автор

- **Катвицкий Спартак** — студент направления DevOps, ИТМО.