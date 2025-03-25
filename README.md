# Distributed Computing course for DevOps 2025

## Описание

Этот проект использует VirtualBox, Vagrant и Ansible для автоматизированного развертывания WordPress с MySQL в контейнерах Docker

## Требования

- **Vagrant** (>= 2.4.3)
- **VirtualBox** (>= 7.1.4)
- **Ansible** (>= 2.18.3)

## Установка и запуск

1. **Клонируйте репозиторий:**

```sh
git clone https://github.com/b-o-e-v/distributed-computing-2025
cd distributed-computing-2025
```

2. Создайте файл `.env`. Пример файла

```ini
MYSQL_ROOT_PASSWORD=pass
MYSQL_DATABASE=wordpress
MYSQL_USER=user
MYSQL_PASSWORD=pass
WORDPRESS_DB_HOST=mysql:3306
WORDPRESS_DB_USER=user
WORDPRESS_DB_PASSWORD=pass
WORDPRESS_DB_NAME=wordpress
```

3. Запустите виртуальную машину Vagrant:

```sh
vagrant up
```

Это создаст виртуальную машину на основе Ubuntu 24.04 (ARM64), настроит ресурсы и пробросит порт 80. Для AMD-процессоров используйте `config.vm.box = "ubuntu/focal64"` в `Vagrantfile`

4. **Настройте Ansible и разверните WordPress:**

```sh
ansible-playbook playbook.yml
```

Этот шаг установит Docker и создаст необходимые контейнеры

5. **Откройте браузер и перейдите по адресу:**

`http://localhost`

Вы должны увидеть экран установки WordPress

## Структура проекта

```none
/
├── Vagrantfile            # Конфигурация виртуальной машины Vagrant
├── playbook.yml           # Ansible Playbook для развертывания Docker и WordPress
├── inventory.ini          # Инвентарь Ansible с настройками хоста
├── ansible.cfg            # Конфигурация Ansible
├── .env                   # Переменные окружения для MySQL и WordPress
├── .gitignore             # Файл исключений для Git
└── README.md              # Описание проекта
```

## Остановка и удаление

Для остановки виртуальной машины используйте:

```sh
vagrant halt
```

Для полного удаления виртуальной машины:

```sh
vagrant destroy -f
```
