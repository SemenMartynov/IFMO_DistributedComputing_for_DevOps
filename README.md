# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

## Используемый стек

- **Ubuntu 24.04**
- **Docker + Docker Compose v2**
- **Установленный Ansible 2.18.4**
- **Доступ по SSH к удалённому хосту**
- **Wordpress 6.7**
- **MariaDB 11.7**

---

## Структура проекта

```
├── _.env                  # Переменные окружения для WordPress и MariaDB
├── .gitignore            # Исключения для Git (например, inventory.ini)
├── docker-compose.yml    # Описание Docker-сервисов
├── LICENSE               # Файл с данными по лизении
├── playbook.yml          # Ansible playbook для установки и запуска
└──  README.md             # Файл с описанием проекат
```

---

## Возможности

- Развёртывание WordPress и MariaDB по одной команде
- Переменные вынесены в `.env` для удобства конфигурации
- Очищаются старые контейнеры перед запуском
- Повторяемый и удобный для CI/CD подход

---

## Предварительные требования

- Ubuntu 24.04
- Установленный **Ansible 2.18.4+**
- Доступ по SSH к удалённому хосту

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

3. Создайте `.env` файл в котором укажите требуемый набор секретов, пример файла есть в репозитории '_.env'
Все секреты указанные в файле '_.env' должны быть изменены, в целях обеспечения безопасности.

4. Запустите Ansible:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

---

## Доступ

После выполнения playbook установщик WordPress будет доступен по адресу:

```
http://<IP-адрес вашего сервера>
```

---

## Автор

Проект подготовлен в рамках курса **"Распределённые вычисления в DevOps"**
**Денис Булгаков**
Май 2025

---