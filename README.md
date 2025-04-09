# Учебный проект 

Развертывание Wordpress + БД в Docker

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