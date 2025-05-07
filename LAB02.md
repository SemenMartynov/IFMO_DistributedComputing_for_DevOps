# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

# Лабораторная работа №2


Требования:
-----------
* выполнить [лабораторную работу №1](/LAB01.md)

Как запустить:
--------------
2 варианта на выбор:
* ```ansible-playbook --inventory carrier, playbook1.yml```
* ```ansible-playbook --inventory carrier, convert-mysql-to-cluster-playbook.yml```

1й вариант создаёт репликацию MASTER -> SLAVE:
--------------
* Останавливает **wordpress**,
* добавляет контейнер MySQL db_replica,
* клонирует данные с основого MySQL используя [clone plugin](https://dev.mysql.com/doc/refman/8.4/en/clone-plugin.html),
* запускает **репликацию** master -> slave
* запускает контейнер **wordpress**.

2й вариант (branch mysql-innodb-cluster) переносит данные MySQL в [InnoDB Cluster](https://dev.mysql.com/doc/mysql-shell/8.4/en/mysql-innodb-cluster.html)
--------------
* Останавливает **wordpress**,
* делает backup MySQL, удаляет контейнер MySQL;
* добавляет три контейнера MySQL и контейнер с MySQL Router
* создаёт отказоустойчивый кластер используя MySQL SHELL
* востанавливает БД,
* персоздаёт и запускает контейнер **wordpress**.

Тестирование:
------------
для автоматизации развёртывания и тестирования работы playbook'а использется [GitHub Actions](https://github.com/features/actions).
