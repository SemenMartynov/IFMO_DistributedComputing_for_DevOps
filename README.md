# IFMO_DistributedComputing_for_DevOps
Лабораторная работа 1.

Создал плейбук, который установит на целевую машину с ОС Ubuntu Docker, а также запустит в нём Wordpress с MariaDB.
Для запуска требуется подключиться из под пользователя с root правами, который может запускать sudo команды без запроса пароля.
На хосте с которого будет происходить управление требуется установить ansible крайней версии:
```
sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository -y --update ppa:ansible/ansible
sudo apt install -y ansible
```
Команда для запуска плейбука:
```
ansible-playbook -i inventory/production/hosts site.yaml --ask-vault-pass
```
В inventory/production/hosts нужно перечислить целевые хосты.
При запросе ввести пароль password (используется в демонстративных целях).
Без шифровки пример файла с переменными в group_vars/all_example.yaml


Лабораторная работа 2.

Создал плейбук, который заходит на целевую машину с установленым в Docker MariaDB и Wordpress.
Во время работы делает бэкап БД, после чего гасит контейнер с Wordpress, создаёт мастер и слейв ноду в контейнерах MariaDB, после чего восстанавливает бэкап и запускает контейнер с Wordpress.
Команда та же для запуска, пароль для group_vars/all.yaml тот же.

Лабораторная работа 3.

Добавил очень простой плейбук, разворачивающий Cadvisor, смотрящий в системе на контейнеры docker и собирающий информацию об их работе. Для запуска достаточно команды:
```
ansible-playbook -i inventory/production/hosts site.yaml
```
Пароль не требуется, переменных окружения нет.

Лабораторная работа 4.

Добавляет кол-во слейвов в кластере Galera. Также поднимает контейнер с Haproxy, который балансирует между всеми нодами mariadb подключение wordpress.