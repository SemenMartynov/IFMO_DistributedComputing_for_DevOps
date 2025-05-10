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
5. Создайте файл `vault_password.txt` со строкой пароля Ansible Vault
5. Зашифруйте переменные: `./encrypt_vars.sh`
6. Запустите плейбук: `ansible-playbook playbook.yml`

После выполнения плейбука, WordPress будет доступен по адресу http://server_ip/

## Результат выполнения
![Результат работы Ansible](images/Screenshot%202025-03-22%20at%2015.12.48.png)
![Работающий WordPress](images/Screenshot%202025-03-22%20at%2014.59.30.png)
