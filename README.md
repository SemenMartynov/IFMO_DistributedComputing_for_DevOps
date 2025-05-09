# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

Требования:
- установленный ansible на хост-машине
- ОС Ubuntu и установленный openssh на сервере(-ах), куда будет устанавливаться wordpress

Инструкция:
1. Изменить файл `wordpress/inventory/hosts`, где надо указать свой сервер
2. Применить `ansible-playbook -i inventory/hosts.yml site.yml`
3. Применить `ansible-playbook -i inventory/hosts.yml replication.yml`
4. Если все сработало - будет доступно по адресу `[ip]:8080` (в базовом примере, `[192.](http://192.168.166.3:8080/)`)

![image](https://github.com/user-attachments/assets/ddccd044-52bc-41f0-9bb3-2817c7f48640)
