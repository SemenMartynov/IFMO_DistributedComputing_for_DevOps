# Wordpress&MySQL Docker Ansible Playbook

Данный Playbook позволяет автоматически установить на указанных серверах docker, создать контейнеры Wordpress и DB Cluster (galera), настроить их взаимодействие, LB haproxy и запустить Wordpress. Так же устанавливает систему мониторинга.

## Требования
- OS: Ubuntu, проверено на 24.04 LTS

## Установка зависимостей
```bash
apt install -y python3 python3-pip ansible
```

## Настройка конфигурации
- Отредактируйте файл `inventory/hosts` и добавьте туда необходимые серверы
- Отредактируйте файл с параметрами базы данных: `playbooks/host_vars/carrier.yml`

## Запуск playbooks
- Первый playbook установит Docker, WordPress, MySQL и все настроит
```
ansible-playbook playbooks/playbook1.yml
```
- Второй playbook преобразует mysql в mysql master & replica
```
ansible-playbook playbooks/playbook2.yml
```
- Третий playbook добавляет мониторинг prometheus+grafana
```
ansible-playbook playbooks/playbook3.yml
```
- Четвертый playbook добавляет galera cluster, haproxy и меняет мониторинг
```
ansible-playbook playbooks/playbook4.yml
```

## Готово!
#### Просьба задавать вопросы в telegram @orionisman