# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025 by Paponova Viktoriya

Playbook для установки wordpress с mysql БД.

Запуск установки:
```bash
ansible-playbook playbook.yaml
```

В файле hosts нужно указать ip адреса и приватные ключи серверов, на которые будет производиться установка. Указать путь к приватным ключам можно в ansible.cfg, либо в hosts файле.