# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

## Описание
Проект для автоматизированного развертывания WordPress с использованием Docker и системы мониторинга на базе Prometheus, Grafana и cAdvisor.

## Системные требования
- Ubuntu 24.04
- Ansible >= 6.0
- Docker на целевых серверах
- Минимум 2 ГБ оперативной памяти
- Минимум 5 ГБ свободного места на диске

## Деплой
1. Клонировать репозиторий:
   ```bash
   git clone https://github.com/DSugakov/IFMO_DistributedComputing_for_DevOps.git
   cd IFMO_DistributedComputing_for_DevOps
   ```

2. Настроить inventory файл:
   - Для локального развертывания (на том же сервере):
     ```
     [wordpress_servers]
     localhost ansible_connection=local
     ```
   - Для удаленного развертывания:
     ```
     [wordpress_servers]
     target_server ansible_host=<IP-адрес> ansible_user=<пользователь> ansible_ssh_private_key_file=~/.ssh/id_rsa
     ```

3. Настроить переменные в `vars/main.yml`:
   - Пароли MySQL
   - Пользователи WordPress
   - Настройки мониторинга

4. Запустить основной плейбук:
   ```bash
   ansible-playbook playbook.yml -i inventory -K
   ```
   Флаг `-K` запрашивает sudo пароль (требуется только при первом запуске)

5. Для отдельного деплоя компонентов:
   - приложение: `ansible-playbook deploy_app.yml -i inventory`
   - мониторинг: `ansible-playbook deploy_monitoring.yml -i inventory`

## Доступ к сервисам
После успешного деплоя, сервисы будут доступны по следующим адресам:

- **WordPress**: http://<host>:8080
- **Grafana**: http://<host>:3000 
  - Логин: `monadmin` (или значение `monitoring_grafana_user` из vars/main.yml)
  - Пароль: `monpassword` (или значение `monitoring_grafana_password` из vars/main.yml)
- **Prometheus**: http://<host>:9090
- **cAdvisor**: http://<host>:8081 (обратите внимание на изменение порта)

## Настройка Grafana
1. Войдите в Grafana с учетными данными
2. Добавьте источник данных Prometheus (URL: http://prometheus:9090)
3. Импортируйте готовые дашборды для Docker (ID: 893, 1860, 10619)