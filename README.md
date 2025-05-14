# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

## Деплой
1. Установить зависимости:
   - Ansible >= 6.0
   - Docker на целевых серверах
2. Заполнить переменные в `vars/main.yml`
3. Запустить основной плейбук:
   ```bash
   ansible-playbook playbook.yml -i inventory
   ```
4. Для отдельного деплоя:
   - приложение: `ansible-playbook deploy_app.yml -i inventory`
   - мониторинг: `ansible-playbook deploy_monitoring.yml -i inventory`
5. Для ручного перезапуска мониторинга можно использовать:
   ```bash
   ansible-playbook manual_monitoring.yml -i inventory
   ```
6. После деплоя:
   - WordPress: http://<host>:8080
   - Grafana: http://<host>:3000 (логин/пароль в переменных)
   - Prometheus: http://<host>:9090
   - cAdvisor: http://<host>:8080
