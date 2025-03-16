# Ansible Role: WordPress with MySQL in Docker

Роль для автоматического развёртывания WordPress и MySQL в изолированных Docker-контейнерах.

## Требования

- **Ansible**
- **Python**
- **Docker** (будет установлен автоматически)
- ОС: Ubuntu/Debian (тестировано на Ubuntu 24.04 LTS)

## Установка зависимостей

```bash
apt install -y python3 python3-pip ansible
ansible-galaxy collection install -r ansible_galaxy_requirements.yml
```

## Клонирование репозитория
```bash
git clone https://github.com/SemenMartynov/IFMO_DistributedComputing_for_DevOps.git -b Gorban_task_1
```

## Запуск развёртывания
```bash
ansible-playbook -i inventory/hosts playbooks/wordpress.yml
```