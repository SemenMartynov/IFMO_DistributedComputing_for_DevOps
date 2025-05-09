# Wordpress&MySQL Docker Ansible Playbook

Данный Playbook позволяет автоматически установить на указанных серверах docker, создать контейнеры Wordpress и MySQL, настроить их взаимодействие и запустить Wordpress.

## Требования
- OS: Ubuntu, проверено на 24.04 LTS


## Установка зависимостей
```bash
apt install -y python3 python3-pip ansible
```

## Настройка конфигурации
- Отредактируйте файл `inventory/hosts` и добавьте туда необходимые серверы
- Отредактируйте файл с параметрами базы данных: `playbooks/group_vars/webservers.yml`

## Запуск playbook
```
ansible-playbook playbooks/docker-wp-mysql.yml
```

## Готово!
#### Просьба задавать вопросы в telegram @orionisman