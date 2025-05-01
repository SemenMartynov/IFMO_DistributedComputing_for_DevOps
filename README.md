# WordPress с MySQL Master-Slave репликацией

Ansible-плейбук для развертывания:

- WordPress (последняя версия)
- MySQL 5.7 в конфигурации Master-Slave
- Автоматическая настройка репликации

## Предварительные требования

1. **Целевые серверы**:

   - Ubuntu 20.04/22.04 или Debian 10/11
   - Минимум 2 GB RAM
   - 10 GB свободного места

2. **Управляющая машина**:
   - Ansible 2.10+
   - Python 3.8+
   - Доступ по SSH к целевым серверам

## Установка зависимостей

```bash
# Установка необходимых collections
ansible-galaxy collection install community.docker community.mysql

# Установка Python-модулей
pip install docker mysql-connector-python
```
