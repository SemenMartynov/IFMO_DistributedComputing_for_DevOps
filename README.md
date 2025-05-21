# Лабораторная работа по Ansible

## Описание

Данная лабораторная работа демонстрирует процесс автоматической установки и настройки веб-сервиса WordPress с использованием Ansible. В результате выполнения проекта создаётся высокодоступная инфраструктура, включающая кластер MariaDB Galera, HAProxy для балансировки нагрузки, сервер WordPress и сервер Nginx для работы сайта.

Сайт WordPress будет доступен по адресу: **http://158.160.97.167**

## Структура проекта

Проект состоит из следующих основных компонентов:

- **playbook1.yml** — установка Docker и подготовка окружения.
- **playbook2.yml** — деплой и настройка реплики MariaDB.
- **playbook3.yml** — установка Prometheus, Grafana и cAdvisor для мониторинга.
- **playbook4.yml** — настройка кластера MariaDB Galera из 5 узлов с HAProxy для обеспечения высокой доступности.

## Минимальные требования для запуска

### Операционная система

- **Ubuntu 24.04.2 LTS**

### Конфигурация сервера

- Процессор: 2 ядра, 2.2 ГГц
- Оперативная память: 4 ГБ (рекомендуется для кластера Galera)
- Жёсткий диск: 40 ГБ (HDD, RAID)
- Сетевая конфигурация: 1 IP-адрес

## Используемые технологии

- Ansible
- Docker, Docker Compose
- WordPress, Nginx
- MariaDB Galera Cluster
- HAProxy для балансировки нагрузки БД
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
   ansible-playbook playbook4.yml --ask-vault-password -i inventory.yml
   ```

4. Перейдите в браузере по адресу:
   ```
   http://<vm-ip>
   ```

## Архитектура кластера Galera

Кластер MariaDB Galera состоит из 5 узлов с синхронной репликацией, что обеспечивает:
- Высокую доступность данных
- Отказоустойчивость (работа продолжается даже при отказе нескольких узлов)
- Масштабируемость для чтения

HAProxy обеспечивает балансировку нагрузки между узлами кластера и автоматически исключает неработающие узлы.

## Мониторинг

После запуска `playbook3.yml`, система мониторинга будет доступна:

- Grafana: `http://<vm-ip>:9100`

## Автор

- **Катвицкий Спартак** — студент направления DevOps, ИТМО.
