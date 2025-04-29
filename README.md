## Проект для развертывания мультиконтейнерного приложения WordPress
### 🏗️ Run
1. Поменять ansible_ssh_private_key_file на свой в group_vars/SERVERS;
2. Поменять ansible_host на свой в inventory.ini;
3. Запустить playbook:
```bash
$ ansible-playbook playbook.yml
```
