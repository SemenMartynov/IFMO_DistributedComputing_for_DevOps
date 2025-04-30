# Учебный проект 

Развертывание Wordpress + БД в Docker

## Task 1

Требуется средствами Ansible развернуть docker с WordPress, вынеся DB в отдельный контейнер.

## Task 2

Для своего инстанса WordPress, заменить БД на cluster, и обеспечить синхронизацию данных.

# Использование

Активировать виртуальное окружение с установленным ansible

`pyenv activate ansible`

Добавить ключ для авторизации по ssh

`eval $(ssh-agent)`

`ssh-add ~/.ssh/itmo_dc`

Проверка связи

`ansible all -m ping -i inventory/hosts.yml`

Запуск

`ansible-playbook playbooks/task1.yml -i inventory/hosts.yml`

`ansible-playbook playbooks/task2.yml -i inventory/hosts.yml`