# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

## Используемый стек

- **Ubuntu 24.04**
- **Docker + Docker Compose v2**
- **Установленный Ansible 2.18.4**
- **Доступ по SSH к удалённому хосту**
- **Wordpress 6.7**
- **MariaDB 11.7**
- **Grafana + Prometheus + cAdvisor (для мониторинга)**

---

## Структура проекта

```
├── vars.yml                             # Переменные Ansible, общие для всех playbook-ов
│
├── playbook1.yml                        # Поднимает WordPress + MariaDB (без кластера)
├── playbook2.yml                        # Преобразует MariaDB в кластер Galera
├── playbook3.yml                        # Разворачивает monitoring-стек (cAdvisor + Prometheus + Grafana)
│
├── docker-compose-basic.yml.j2         # Шаблон Docker Compose без кластера
├── docker-compose-galera.yml.j2        # Шаблон Docker Compose с кластером Galera
├── docker-compose-monitoring.yml.j2    # Шаблон Docker Compose для мониторинга
│
├── prometheus.yml.j2                   # Конфигурация Prometheus для сбора метрик
│
├── requirements.yml                    # Зависимости Ansible (например, community.docker)
├── LICENSE                             # Файл лицензии
└── README.md                           # Документация проекта
```

---

## Возможности

- Развёртывание WordPress и MariaDB по одной команде
- Поэтапное преобразование базы данных в кластер Galera
- Развёртывание полноценного мониторинга контейнеров через Prometheus и Grafana
- Автоматический импорт готового дашборда Grafana для cAdvisor
- Повторяемый подход, удобный для CI/CD
- Проверка доступности сервисов (WordPress и Grafana) встроена в playbook-и

---

## Предварительные требования

- Ubuntu 24.04
- Установленный **Ansible 2.18.4+**
- Доступ по SSH к удалённому хосту
- Docker и Docker Compose v2 на удалённом хосте (можно установить автоматически через playbook)

---

## Установка

1. Клонируйте репозиторий:

```bash
git clone https://github.com/praeitor/IFMO_DistributedComputing_for_DevOps.git
cd IFMO_DistributedComputing_for_DevOps.git
```

2. Создайте `inventory.ini` и укажите IP и SSH-параметры:

```bash
touch inventory.ini
```

```ini
[wordpress]
<IP-адрес вашего сервера> ansible_user=your_user ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3
```

3.	Создайте vars.yml и задайте значения всех нужных переменных, включая пароли БД, логины Grafana и прочее. Пример — в комментариях к playbook.

4. Запуск плейбуков Ansible:

```bash
ansible-playbook -i inventory.ini playbook1.yml    # Базовая установка WordPress + MariaDB
ansible-playbook -i inventory.ini playbook2.yml    # Преобразование MariaDB в кластер Galera
ansible-playbook -i inventory.ini playbook3.yml    # Мониторинг: Prometheus + cAdvisor + Grafana
```

---

## Доступ

После выполнения playbook установщик WordPress будет доступен по адресу:

```
WordPress: http://<IP-адрес вашего сервера>
Grafana: http://<IP-адрес вашего сервера>:3000
Логин по умолчанию: admin / 3l337supersecure (или указан в vars.yml)
Дашборд для cAdvisor (id 193) будет импортирован автоматически
```

---

## Автор

Проект подготовлен в рамках курса **"Распределённые вычисления в DevOps"**
**Денис Булгаков**
Май 2025

---