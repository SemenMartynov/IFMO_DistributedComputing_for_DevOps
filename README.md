# Ansible Role: WordPress with MySQL in Docker

## Лабораторная работа 1

Роль для автоматического развёртывания WordPress и MySQL в изолированных Docker-контейнерах.

### Требования

- **Ansible**
- **Python**
- **Docker** (будет установлен автоматически)
- ОС: Ubuntu/Debian (тестировано на Ubuntu 24.04 LTS)

### Установка зависимостей

```bash
apt install -y python3 python3-pip ansible
ansible-galaxy collection install -r ansible_galaxy_requirements.yml
```

### Запуск развёртывания
```bash
cd Ansible/
ansible-playbook -i inventory/hosts playbooks/wordpress.yml
```

## Лабораторная работа 2

Роль для автоматического развёртывания WordPress и кластера MySQL с синхронизацией данных в изолированных Docker-контейнерах.

### Файлы выполнения плейбука
После выполнения плейбука все файлы хранятся по пути `playbook_files/<playbook_name>/`.

### Запуск развёртывания
```bash
cd Ansible/
ansible-playbook -i inventory/hosts playbooks/wordpress_with_cluster.yml
```

### Проверка успешности репликации
Ввод команды ниже со стороны реплики должен выдать информацию о подключении к мастер-ноде.
```bash
SHOW REPLICA STATUS;
```

## Лабораторная работа 3

Роль для автоматического развёртывания Prometheus + Grafana для MySQL.

Дополнительно нужно поменять значение в hosts и roles/monitoring/files/prometheus_grafana.yml

### Файлы выполнения плейбука
После выполнения плейбука все файлы хранятся по пути, указанному в переменной `monitoring_dir`.

### Запуск развёртывания
```bash
cd Ansible/
ansible-playbook -i inventory/hosts playbooks/monitoring.yml
```

### Результат развёртывания
В результате должны быть доступны приложения по портам из `roles/monitoring/defaults/main.yml`

Grafana идёт с предустановленным саморучно созданным dashboard с одной метрикой на потребление CPU (как proof of concept, что оно работает). Логин и пароль для входа в Grafana стандартный и не менялся: admin/admin