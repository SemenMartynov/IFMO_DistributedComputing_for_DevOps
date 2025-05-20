**Настройка репликации WordPress MySQL с помощью Ansible**

Это руководство описывает процесс настройки репликации MySQL в режиме мастер–слейв для WordPress с использованием Docker и Ansible.

---

## Необходимые условия

- Ansible версии 2.9 и выше установлен на управляющей машине
- Доступ по SSH к серверам (мастер и слейв)
- Зависимости Python и Docker устанавливаются с помощью Ansible

---

## 1. Настройка инвентарного файла (`hosts.ini`)

Откройте файл `hosts.ini` и пропишите мастер- и слейв-узлы. Пример:

```ini
[mysql_master]
51.250.40.190 ansible_ssh_private_key_file=/home/ilen/.ssh/id_rsa ansible_user=ilen

[mysql_slave]
130.193.59.47 ansible_ssh_private_key_file=/home/ilen/.ssh/id_rsa ansible_user=ilen
```

> **Примечание:** Замените 51.250.40.190 и 130.193.59.47 на реальные IP-адреса или доменные имена.

---

## 2. Установка зависимостей Docker

Сначала установите Docker и все необходимые библиотеки на целевых хостах:

```bash
ansible-playbook install_docker.yml
```

Этот плейбук:

- Установит Docker Engine
- Установит `docker-py` и другие Python-библиотеки, необходимые для работы с Docker в Ansible
- Убедится, что демон Docker запущен и включен в автозагрузку

---

## 3. Развёртывание мастера WordPress

Запустите плейбук установки мастера:

```bash
ansible-playbook install_master_wordpress.yml
```

Этот плейбук:

- Запускает контейнер MySQL в режиме мастера
- Разворачивает контейнер WordPress, подключённый к мастер-базе данных

---

## 4. Развёртывание слейва и запуск репликации

Запустите плейбук настройки слейва:

```bash
ansible-playbook install_slave.yml
```

Этот плейбук:

- Запускает контейнер MySQL в режиме слейва
- Подключает его

```
TASK [Вывести основные показатели репликации] **********************************************
ok: [130.193.59.47] => {
    "msg": [
        "Master_Host: 51.250.40.190",
        "Slave_IO_Running: Yes",
        "Slave_IO_State: Waiting for master to send event",
        "Slave_SQL_Running: Yes",
        "Slave_SQL_Running_State: Reading event from the relay log"
    ]
}

PLAY RECAP *********************************************************************************
130.193.59.47              : ok=18   changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```