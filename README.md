# WordPress + MySQL Deployment via Ansible  
### Автор: Eduard Bodreev

## Описание

Проект разворачивает мультиконтейнерное приложение с WordPress и MySQL с помощью **Ansible** и **Docker**.  
Все действия выполняются на удалённом сервере, доступ к которому осуществляется по SSH.

## Требования

- Установленный Ansible (на локальной машине)
- SSH-доступ к серверу с root-доступом или sudo без пароля
- Настроенный `inventory.ini` с IP-адресом сервера и пользователем

## Установка

1. Склонировать репозиторий:
   ```bash
   git clone https://github.com/Eduard-Bodreev/IFMO_DistributedComputing_for_DevOps
   cd wordpress-ansible
