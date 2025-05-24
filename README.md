# Distributed Computing ITMO

## Студент: Павлюченков Евгений
### [Ссылка на разворачиваемый проект](https://github.com/loveavoider/kittygram)

## Инструкция по запуску
#### 1. Скопировать _env.example в .env
```bash
cp ansible/files/_env.example ansible/files/.env
```
#### 2. Поменять хосты в файлах
```
ansible/hosts
ansible/files/configs/.pgpass
ansible/files/configs/postgresql.conf
ansible/configure_replica_playbook.yml (в переменной master_host)
```
