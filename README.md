# Distributed Computing course for DevOps 2025

## Описание

Этот проект предоставляет Ansible Playbook для автоматического развертывания WordPress с использованием MySQL в Docker-контейнерах. В процессе установки на сервер будет настроена репликация между двумя экземплярами MySQL (Master и Slave). Проект доступен по следующему адресу: http://51.250.88.42

## Требования

- **Ansible** (>= 2.18.3)
- **Docker** (>= 28.0.4)
- **Docker Compose** (>= 2.34.0)
- **Git** (для клонирования репозитория)

## Установка и запуск

1. **Клонируйте репозиторий:**

```sh
git clone https://github.com/b-o-e-v/distributed-computing-2025
cd distributed-computing-2025
```

2. Настройте свой inventory.ini файл, указав правильные данные для подключения к серверу:

```ini
[web]
<IP_сервера> ansible_port=22 ansible_user=user ansible_ssh_private_key_file=~/.ssh/distributed_computing/private_key
```

3. **Настройте Ansible и разверните WordPress:**

```sh
ansible-playbook playbook.yml
```

Этот шаг установит Docker, создаст необходимые контейнеры и настроит репликацию между двумя экземплярами MySQL

4. **Откройте браузер и перейдите по адресу:**

`http://<IP_сервера>`

Вы должны увидеть экран установки WordPress

## Структура проекта

```none
/
├── roles/
|    └── docker_installation/
|       └── tasks/
|           └── main.yml   # Задачи для установки и настройки Docker
├── ansible.cfg            # Конфигурация Ansible
├── .gitignore             # Игнорируемые файлы
├── .env                   # Переменные окружения для MySQL и WordPress
├── inventory.ini          # Конфигурация хостов для Ansible
├── master.cnf             # Конфигурация MySQL Master
├── slave.cnf              # Конфигурация MySQL Slave
└── playbook.yml           # Главный Ansible Playbook для развертывания
└── README.md              # Описание проекта
```
