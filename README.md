### Запуск playbook
```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
ansible-playbook -i inventory.ini monitoring-playbook.yml
```

### Доступ к мониторингу

После успешного выполнения плейбука, мониторинг будет доступен по следующим адресам:

- **Prometheus**: http://51.250.33.142:9090
- **Grafana**: http://51.250.33.142:3000 (логин: admin, пароль: admin)
- **cAdvisor**: http://51.250.33.142:8081

