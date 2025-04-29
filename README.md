# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

# Развертывание WordPress с помощью Ansible и Docker

Этот проект содержит Ansible-конфигурацию для развертывания WordPress и MySQL в отдельных Docker-контейнерах на удаленном сервере.

## Структура проекта

- `ansible.cfg` - конфигурация Ansible
- `inventory.ini` - инвентарный файл с хостами
- `playbook.yml` - основной плейбук
- `templates/` - шаблоны для Docker Compose и .env файла
- `group_vars/` - переменные для групп хостов (зашифрованы с Ansible Vault)
- `vault_password.txt` - файл с паролем для Ansible Vault
- `encrypt_vars.sh` - скрипт для шифрования переменных
- `id_rsa` - приватный SSH-ключ для подключения к серверу

## Особенности проекта

- **Настроенное SSH-подключение**: Подключение выполняется от пользователя ansible с использованием SSH-ключа
- **Поддержка уже установленного Docker**: Плейбук автоматически определяет наличие Docker и Docker Compose на сервере и пропускает шаги установки, если они уже установлены.
- **Cовместимость с Ubuntu 24.04**: Плейбук следует официальному руководству по установке Docker для Ubuntu 24.04.
- **Повышение привилегий через sudo**: Плейбук использует механизм become для получения root-привилегий
- Чувствительные данные (пароли, учетные данные) хранятся в зашифрованном виде с помощью Ansible Vault
- Пароли от базы данных генерируются как сложные строки
- Переменные окружения передаются через .env файл, который имеет ограниченные права доступа
- Контейнеры запускаются в изолированной сети Docker

## Зависимости

- Ansible 2.9 или новее
- Коллекция community.docker (`ansible-galaxy collection install community.docker`)

## Использование

1. Поместите приватный SSH-ключ в корень проекта
2. Настройте `inventory.ini` с IP адресом вашего сервера
3. Настройте remote_user, vault_password_file, private_key_file, vault_password_file в `ansible.cfg`
4. Отредактируйте переменные в `group_vars/wordpress_server` (пароли, имена пользователей)
5. (опционально)Создайте файл `vault_password.txt` со строкой пароля Ansible Vault
5. (опционально)Зашифруйте переменные: `./encrypt_vars.sh`
6. Запустите плейбук: `ansible-playbook playbook1.yml`

После выполнения плейбука, WordPress будет доступен по адресу http://server_ip/

# Настройка кластера MySQL для WordPress

## Особенности

- Использует модуль `community.mysql.mysql_replication` для автоматической настройки репликации

## Использование

1. Добавьте хост в inventory.ini:
   ```
   [wordpress_server]
   your_server_ip
   ```

2. Настройте переменные группы в group_vars/wordpress_server:
   ```yaml
   mysql_root_password: "secure_root_password"
   mysql_database: "wordpress"
   mysql_user: "wordpress"
   mysql_password: "secure_password"
   repl_user: "repl_user"
   repl_password: "secure_repl_password"
   wp_table_prefix: "wp_"
   ```

3. Запустите playbook:
   ```bash
   ansible-playbook playbook2.yml
   ```

## Настройка кластера

Вы можете изменить параметры кластера, переопределив переменные роли в вашем playbook или в group_vars:

```yaml
mysql_cluster_nodes: 5  # Увеличить количество узлов кластера до 5
```

## Проверка работы кластера

1. Подключение к основному узлу:
   ```
   ssh ansible@your_server_ip
   docker exec -it mysql_node_1 mysql -uroot -p
   ```

2. Проверка статуса мастера:
   ```sql
   SHOW MASTER STATUS;
   ```
3. Проверка статуса репликации:
   ```sql
   SHOW REPLICA STATUS\G;
   ```

# Мониторинг кластера MySQL

## Обзор

Эта система мониторинга предоставляет возможность отслеживать производительность и состояние кластера MySQL с использованием набора инструментов: cAdvisor, Prometheus и Grafana.

## Компоненты

- **cAdvisor**: Анализирует использование ресурсов и производительность контейнеров Docker.
- **Prometheus**: Система сбора и хранения метрик с временными рядами.
- **Grafana**: Платформа для визуализации метрик и создания информационных панелей.

Подробнее о компонентах:
- [cAdvisor](https://github.com/google/cadvisor)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)

## Установка и настройка

Мониторинг настраивается с помощью Ansible Playbook:

```bash
ansible-playbook playbook3.yml
```

## Доступ к интерфейсам мониторинга

После установки вы можете получить доступ к интерфейсам:

- cAdvisor: `http://wordpress_server_ip:8080`
- Prometheus: `http://wordpress_server_ip:9090`
- Grafana: `http://wordpress_server_ip:9100`

Логин и пароль для Grafana указаны в файле `.env`.
