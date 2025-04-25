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
130.193.59.198 ansible_ssh_private_key_file=/home/ilen/.ssh/id_rsa ansible_user=ilen

[mysql_slave]
84.252.133.154 ansible_ssh_private_key_file=/home/ilen/.ssh/id_rsa ansible_user=ilen
```

> **Примечание:** Замените 130.193.59.198 и 84.252.133.154 на реальные IP-адреса или доменные имена.

---

## 2. Установка зависимостей Docker

Сначала установите Docker и все необходимые библиотеки на целевых хостах:

```bash
ansible-playbook -i hosts.ini install_docker.yml
```

Этот плейбук:

- Установит Docker Engine
- Установит `docker-py` и другие Python-библиотеки, необходимые для работы с Docker в Ansible
- Убедится, что демон Docker запущен и включен в автозагрузку

---

## 3. Развёртывание мастера WordPress

Запустите плейбук установки мастера:

```bash
ansible-playbook -i hosts.ini install_master_wordpress.yml
```

Этот плейбук:

- Запускает контейнер MySQL в режиме мастера
- Разворачивает контейнер WordPress, подключённый к мастер-базе данных

---

## 4. Получение информации о бинарных логах мастера

После успешного запуска мастер плейбука вы увидете информацию:

Вывод будет примерно таким:

```
TASK [Вывод информации о мастере] **********************************************************
ok: [130.193.59.198] => {
    "msg": [
        "Master host: 130.193.59.198",
        "Master log file: mysql-bin.000003",
        "Master log position: 761"
    ]
}

PLAY RECAP *********************************************************************************
130.193.59.198             : ok=17   changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

- **Файл:** `mysql-bin.000003`
- **Позиция:** `761`

---

## 5. Настройка переменных в `install_slave.yml`

Откройте файл `install_slave.yml` и в блоке `vars:` укажите параметры из предыдущего шага:

```yaml
vars:
  master_log_file: "mysql-bin.000003"
  master_log_pos: 761
```

Также убедитесь, что остальные параметры указаны корректно:

```yaml
vars:
  master_host: "master.example.com"
  replication_user: repl_user
  replication_password: repl_pass
  master_log_file: "mysql-bin.000003"
  master_log_pos: 761
```

---

## 6. Развёртывание слейва и запуск репликации

Запустите плейбук настройки слейва:

```bash
ansible-playbook -i hosts.ini install_slave.yml
```

Этот плейбук:

- Запускает контейнер MySQL в режиме слейва
- Подключает его

```
TASK [Display slave status] ****************************************************************
ok: [84.252.133.154] => {
    "slave_status.stdout_lines": [
        "*************************** 1. row ***************************",
        "               Slave_IO_State: Waiting for master to send event",
        "                  Master_Host: 130.193.59.198",
        "                  Master_User: replication",
        "                  Master_Port: 3306",
        "                Connect_Retry: 60",
        "              Master_Log_File: mysql-bin.000003",
        "          Read_Master_Log_Pos: 761",
        "               Relay_Log_File: mysql-relay-bin.000002",
        "                Relay_Log_Pos: 320",
        "        Relay_Master_Log_File: mysql-bin.000003",
        "             Slave_IO_Running: Yes",
        "            Slave_SQL_Running: Yes",
        "              Replicate_Do_DB: wordpress",
        "          Replicate_Ignore_DB: ",
        "           Replicate_Do_Table: ",
        "       Replicate_Ignore_Table: ",
        "      Replicate_Wild_Do_Table: ",
        "  Replicate_Wild_Ignore_Table: ",
        "                   Last_Errno: 0",
        "                   Last_Error: ",
        "                 Skip_Counter: 0",
        "          Exec_Master_Log_Pos: 761",
        "              Relay_Log_Space: 527",
        "              Until_Condition: None",
        "               Until_Log_File: ",
        "                Until_Log_Pos: 0",
        "           Master_SSL_Allowed: No",
        "           Master_SSL_CA_File: ",
        "           Master_SSL_CA_Path: ",
        "              Master_SSL_Cert: ",
        "            Master_SSL_Cipher: ",
        "               Master_SSL_Key: ",
        "        Seconds_Behind_Master: 0",
        "Master_SSL_Verify_Server_Cert: No",
        "                Last_IO_Errno: 0",
        "                Last_IO_Error: ",
        "               Last_SQL_Errno: 0",
        "               Last_SQL_Error: ",
        "  Replicate_Ignore_Server_Ids: ",
        "             Master_Server_Id: 1",
        "                  Master_UUID: ebbb916f-219a-11f0-8ef6-1e46f36fab83",
        "             Master_Info_File: /var/lib/mysql/master.info",
        "                    SQL_Delay: 0",
        "          SQL_Remaining_Delay: NULL",
        "      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates",
        "           Master_Retry_Count: 86400",
        "                  Master_Bind: ",
        "      Last_IO_Error_Timestamp: ",
        "     Last_SQL_Error_Timestamp: ",
        "               Master_SSL_Crl: ",
        "           Master_SSL_Crlpath: ",
        "           Retrieved_Gtid_Set: ",
        "            Executed_Gtid_Set: ",
        "                Auto_Position: 0",
        "         Replicate_Rewrite_DB: ",
        "                 Channel_Name: ",
        "           Master_TLS_Version: "
    ]
}

PLAY RECAP *********************************************************************************
84.252.133.154             : ok=17   changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```