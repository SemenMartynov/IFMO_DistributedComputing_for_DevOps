# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

# Лабораторная №2
==============
Требования:
-----------
* выполнить [[LAB01.md|лабораторную работу №1]]

Как запустить:
--------------
2 варианта на выбор:
* ```ansible-playbook -K -i ans-inv-hosts convert-mysql-to-master->slave-playbook.yml```
* ```ansible-playbook -K -i ans-inv-hosts convert-mysql-to-cluster-playbook.yml```

1й вариант создаёт репликацию MASTER -> SLAVE:
--------------
* Останавливает **wordpress**,
* добавляет контейнер MySQL dbslave,
* клонирует данные с основого MySQL используя [clone plugin](https://dev.mysql.com/doc/refman/8.4/en/clone-plugin.html),
* запускает **репликацию** master -> slave
* запускает контейнер **wordpress**.

2й вариант переносит данные MySQL в [InnoDB Cluster](https://dev.mysql.com/doc/mysql-shell/8.4/en/mysql-innodb-cluster.html)
--------------
* Останавливает **wordpress**,
* делает backup MySQL, удаляет контейнер MySQL;
* добавляет 3 контейнера MySQL и контейнер с MySQL Router
* создаёт отказоустойчивый кластер используя MySQL SHELL
* востанавливает БД,
* запускает контейнер **wordpress**.

Тестирование:
------------
для автоматизации развёртывания и тестирования работы playbook'а использется [GitHub Actions](https://github.com/features/actions).
