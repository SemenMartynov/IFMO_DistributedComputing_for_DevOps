# Wordpress&MySQL Docker Ansible Playbook

Данный Playbook позволяет автоматически установить на указанных серверах docker, создать контейнеры Wordpress и MySQL (Master+replica), настроить их взаимодействие и запустить Wordpress. Так же устанавливает систему мониторинга.

## Требования
- OS: Ubuntu, проверено на 24.04 LTS

## Установка зависимостей
```bash
apt install -y python3 python3-pip ansible
```

## Настройка конфигурации
- Отредактируйте файл `inventory/hosts` и добавьте туда необходимые серверы
- Отредактируйте файл с параметрами базы данных: `playbooks/group_vars/webservers.yml`

## Запуск playbooks
- Первый playbook установит Docker, WordPress, MySQL и все настроит
```
ansible-playbook playbooks/docker-wp-mysql.yml
```
- Второй playbook преобразует mysql в mysql master & replica
```
ansible-playbook playbooks/playbook-2-cluster.yml
```
- 
- Третий playbook добавляет мониторинг prometheus+grafana
```
ansible-playbook playbooks/playbook-3-monitoring.yml
```

## Готово!
#### Просьба задавать вопросы в telegram @orionisman