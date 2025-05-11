# Ansible Playbook для WordPress

Этот репозиторий автоматизирует развёртывание платформы WordPress с кластером PostgreSQL, обратным прокси Nginx и контейнеризацией через Docker под управлением Ansible.

## 📂 Структура репозитория

```bash
tree .
.
├── Makefile                   # команды для установки и запуска
├── README.md                  # этот файл
├── inventory/                 # папка инвентаря
│   └── hosts                  # файл с хостами
├── requirements.yml           # зависимости Ansible Collection
├── roles/                     # роли Ansible
│   ├── common/                # базовая системная настройка и UFW
│   │   ├── handlers/
│   │   │   └── main.yml
│   │   └── tasks/
│   │       └── main.yml
│   ├── docker/                # установка Docker, Compose v2 и сети
│   │   └── tasks/
│   │       └── main.yml
│   ├── nginx/                 # генерация SSL и прокси Nginx
│   │   └── tasks/
│   │       └── main.yml
│   ├── postgres/              # кластер PostgreSQL master/replica
│   │   ├── vars/
│   │   │   └── main.yml
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   └── templates/
│   │       └── docker-compose.yml.j2
│   └── wordpress/             # деплой WordPress через Docker Compose
│       ├── handlers/
│       │   └── main.yml
│       ├── vars/
│       │   └── main.yml
│       ├── tasks/
│       │   └── main.yml
│       └── templates/
│           ├── docker-compose.yml.j2
│           └── nginx.conf.j2
└── site.yml                   # главный playbook
```

## ⚙️ Требования

* Контролирующая машина с Ansible ≥ 2.18
* Python 3 и SSH-доступ к целевым хостам
* Установленный `make` (утилита Make)
* Права на установку пакетов на хостах (sudo)

## 🔧 Установка и запуск

1. Клонируйте репозиторий и перейдите в папку проекта:

   ```bash
   git clone <repo-url>
   cd <repo-dir>
   ```
2. Выполните команду запуска через Makefile:

   ```bash
   make            # install, ping, run
   ```

Или вручную:

```bash
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory/hosts site.yml
```

## 🗂 Inventory

Пример файла `inventory/hosts`:

```ini
[wordpress_servers]
server1.example.com ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
```

## 📝 Переменные конфигурации

Значения по умолчанию задаются в `roles/*/vars/main.yml`. Переопределяйте через `group_vars/all.yml` или флаг `-e`.

| Переменная                  | Значение по умолчанию | Описание                                  |
| --------------------------- | --------------------- | ----------------------------------------- |
| `postgres_user`             | `wp_user`             | Суперпользователь PostgreSQL              |
| `postgres_password`         | `secret`              | Пароль пользователя PostgreSQL            |
| `postgres_replica_user`     | `replicator`          | Пользователь репликации                   |
| `postgres_replica_password` | `replica_pass`        | Пароль репликации                         |
| `wordpress_db_user`         | `wp_user`             | Пользователь БД для WordPress             |
| `wordpress_db_password`     | `secret`              | Пароль БД для WordPress                   |
| `docker_compose_path`       | `/opt/wordpress`      | Путь до каталога с Docker Compose файлами |
| `env_file_path`             | `/opt/wordpress/.env` | Путь до файла окружения `.env`            |

## 🚀 Использование

* **Развернуть или обновить**:

  ```bash
  make run
  ```
* **Проверить доступность хостов**:

  ```bash
  make ping
  ```

## 📖 Описание ролей

* **common**: установка UFW, открытие портов 22/80/443
* **docker**: установка Docker, плагина Compose v2, создание сети `wp_net`
* **postgres**: развертывание кластера PostgreSQL (master + replica)
* **wordpress**: подготовка Docker Compose для WordPress, ожидание БД и запуск контейнеров
* **nginx**: генерация self-signed SSL сертификата и обратный прокси

## 🔄 Идемпотентность

Все задачи идемпотентны: плейбук можно безопасно запускать повторно для применения изменений.
