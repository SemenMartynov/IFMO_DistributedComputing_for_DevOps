# 📦 IFMO Distributed Computing for DevOps (2025)

**Автоматизированный деплой WordPress + MariaDB** с использованием Docker, Docker Compose и Ansible.

## 🔧 Стек технологий
- Ubuntu 24 LTS
- Docker 
- Docker Compose
- Ansible 2.18
- WordPress 6.7
- MariaDB 11.7

## 💡 Возможности
- Развёртывание одной командой
- Очистка старых контейнеров
- Готово для CI/CD

## ⚙️ Установка
```bash
  git clone git@github.com:B10nicle/IFMO_DistributedComputing_for_DevOps.git
  cd IFMO_DistributedComputing_for_DevOps
```

## ✍️ Создание inventory.ini:
```ini
[wordpress]
<SERVER_IP> ansible_user=USER ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3.12
```

## 🚀 Запуск
```bash
  ansible-playbook -i inventory.ini ansible/playbook.yml
```

## 🌐 Проверка
http://<SERVER_IP>
