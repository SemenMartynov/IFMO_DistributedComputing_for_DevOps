# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025 by Paponova Viktoriya

# Playbook для установки wordpress с mysql БД.

Запуск установки:
```bash
ansible-playbook wordpress.yaml
```

В файле hosts нужно указать ip адреса и приватные ключи серверов, на которые будет производиться установка. Указать путь к приватным ключам можно в ansible.cfg, либо в hosts файле.

# Playbook для разворачивания кластера БД mysql
```bash
ansible-playbook playbook_cluster.yaml
```

# Playbook для настройки мониторинга с Prometheus и Grafana
```bash
ansible-playbook playbook_monitoring.yaml
```

- Prometheus будет доступен по адресу http://<ip_адрес_сервера>:9090/query
- Grafana будет доступна по адресу http://<ip_адрес_сервера>:3000/dashboards