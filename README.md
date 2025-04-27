# Distributed Computing course for DevOps 2025

## Описание

Этот проект предоставляет Ansible Playbook для автоматического развертывания WordPress с использованием MySQL в Docker-контейнерах. В процессе установки на сервер будет настроена репликация между двумя экземплярами MySQL (Master и Slave). Также включена система мониторинга с использованием Prometheus, Grafana и MySQL Exporter.

Проект доступен по следующему адресу: http://51.250.88.42

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

Настройте файл `inventory.ini`, указав данные для подключения к серверу:

```ini
[web]
<IP_сервера> ansible_port=22 ansible_user=user ansible_ssh_private_key_file=~/.ssh/distributed_computing/private_key
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

### Настройка

1. **Prometheus**:
   - Конфигурация Prometheus хранится в файле `roles/monitoring/files/prometheus.yml`.
   - Prometheus собирает метрики с MySQL Exporter для Master и Slave.

2. **Grafana**:
   - Grafana автоматически настраивается с помощью Ansible.
   - Источник данных Prometheus добавляется в Grafana.
   - Загружается и настраивается дашборд "MySQL Overview".

3. **MySQL Exporter**:
   - Экспортеры запускаются для MySQL Master и Slave.
   - Конфигурационные файлы для экспортеров создаются динамически с использованием шаблона `roles/monitoring/templates/config.my-cnf.j2`.

### Как проверить

1. **Prometheus**:
   - Откройте в браузере: `http://51.250.88.42:9090/targets`.
   - Убедитесь, что метрики собираются.

2. **Grafana**:
   - Откройте в браузере: `http://51.250.88.42:3000`.
   - Войдите с использованием учетных данных:
     - Логин: `admin`
     - Пароль: `adminpass`
   - Перейдите на дашборд "MySQL Overview".

---

## Структура проекта

```none
/
├── roles/
|    ├── docker_installation/
|    |   └── tasks/
|    |       └── main.yml             # Установка Docker
|    ├── wordpress_mysql_setup/
|    |   ├── tasks/
|    |   |   └── main.yml             # Настройка MySQL Master-Slave и WordPress
|    |   ├── vars/
|    |   |   └── main.yml             # Переменные для MySQL и WordPress
|    |   └── templates/
|    |       └── mysql-cnf.j2         # Шаблон конфигурации MySQL
|    └── monitoring/
|        ├── tasks/
|        |   └── main.yml             # Настройка Prometheus, Grafana и MySQL Exporter
|        ├── vars/
|        |   └── main.yml             # Переменные для мониторинга
|        ├── files/
|        |   └── prometheus.yml       # Конфигурация Prometheus
|        └── templates/
|            └── config.my-cnf.j2     # Шаблон конфигурации MySQL Exporter
├── ansible.cfg                       # Конфигурация Ansible
├── inventory.ini                     # Конфигурация хостов для Ansible
├── playbook.yml                      # Главный Ansible Playbook
└── README.md                         # Описание проекта
```
