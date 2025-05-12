# Distributed Computing course for DevOps 2025

## Описание

Этот проект предоставляет Ansible Playbook для автоматического развертывания WordPress с использованием MySQL/MariaDB в Docker-контейнерах. В процессе установки на сервер будет настроена репликация между двумя экземплярами MySQL (Master и Slave), а также полноценный Galera Cluster. Также включена система мониторинга с использованием Prometheus, Grafana, MySQL Exporter и HAproxy Servers.

Проект доступен по следующему адресу: http://51.250.2.146

---

## Требования

- **Ansible** (>= 2.18.3)
- **Docker** (>= 28.0.4)
- **Docker Compose** (>= 2.34.0)
- **Git** (для клонирования репозитория)

---

## Установка и запуск

### 1. Установка зависимостей

Перед началом работы установите необходимые коллекции Ansible:

```bash
ansible-galaxy collection install -r requirements.yml
```

### 2. Клонирование репозитория

Клонируйте репозиторий и перейдите в директорию проекта:

```bash
git clone https://github.com/b-o-e-v/distributed-computing-2025
cd distributed-computing-2025
```

### 3. Настройка inventory.ini

Настройте файл `inventory.yml`, указав данные для подключения к серверу:

```yml
all:
  hosts:
    carrier:
      ansible_host: ...
      ansible_user: ...
      ansible_become_method: sudo
      ansible_ssh_private_key_file: ...
      ansible_password: ...
      ansible_become_pass: ...
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
```

### 4. Запуск плейбука

Запустите плейбук для развертывания WordPress и настройки мониторинга:

```bash
ansible-playbook playbook.yml
```

После выполнения плейбука WordPress будет доступен по адресу: `http://<IP_сервера>`.

---

## Мониторинг

### Описание

Мониторинг реализован с использованием следующих компонентов:
- **Prometheus**: Система сбора и хранения метрик.
- **Grafana**: Визуализация метрик и создание дашбордов.
- **MySQL Exporter**: Экспортер метрик MySQL для Prometheus.
- **HAproxy Servers | HAproxy**: Экспортер метрик HAproxy для Prometheus.

### Настройка

1. **Prometheus**:
   - Конфигурация Prometheus хранится в файле `prometheus.yml`, он генерируется из j2 шаблона.
   - Prometheus собирает метрики с MySQL Exporter и HAproxy Servers.

2. **Grafana**:
   - Grafana автоматически настраивается с помощью Ansible.
   - Источник данных Prometheus добавляется в Grafana.
   - Загружаются и настраиваются дашборды "MySQL Overview" и "HAproxy Servers".

3. **MySQL Exporter**:
   - Экспортеры запускаются для MySQL и HAproxy.
   - Конфигурационные файлы для экспортеров создаются динамически с использованием шаблона `roles/monitoring/templates/config.my-cnf.j2`.

3. **HAproxy**:
   - Конфигурация балансировщика HAproxy хранится в файле `haproxy.cfg`, он генерируется из j2 шаблона.

### Как проверить

1. **Prometheus**:
   - Откройте в браузере: `http://51.250.2.146:9090/targets`.
   - Убедитесь, что метрики собираются.

2. **Grafana**:
   - Откройте в браузере: `http://51.250.2.146:3000/dashboards`.
   - Войдите с использованием учетных данных:
     - Логин: `admin`
     - Пароль: `adminpass`
   - Перейдите на конкретный дашборд ("MySQL Overview" и "HAproxy Servers").

3. **HAproxy**
   - Дополнительно HAproxy можно проверить по адресу `http://51.250.2.146:8404/stats`
   - Войдите с использованием учетных данных:
     - Логин: `admin`
     - Пароль: `adminpass`

---

## Структура проекта

```none
/
├── group_vars/
|   └── all.yml                      # Переменные окружения
├── roles/
|   └── docker_installation/
|        └── tasks/
|            └── main.yml             # Установка Docker
├── roles/
|   └── templates/                    # Шаблоны для генерации конфигураций
|       ├── config.my-cnf.j2
|       ├── haproxy.cfg.j2
|       ├── mysql-cnf.j2
|       ├── prometheus-galera.yml.j2
|       └── prometheus.yml.j2
├── playbook1.yml                     # Playbook: Установка WordPress с базой данных MySQL
├── playbook2.yml                     # Playbook: Настройка Master-Slave репликации MySQL
├── playbook3.yml                     # Playbook: Развёртывание мониторинга Prometheus и Grafana
├── playbook4.yml                     # Playbook: Создание кластера из 5 узлов на базе Galera Cluster
├── ansible.cfg
├── inventory.yml
├── .gitignore
├── .ansible-lint.yaml
├── requirements.yml
├── LICENSE
└── README.md
```
