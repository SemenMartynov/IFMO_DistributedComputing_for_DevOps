# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

# Лабораторная работа №3

Требования:
-----------
* выполнить [лабораторную работу №2](/LAB02.md)

Как запустить:
--------------
* ```ansible-playbook --inventory carrier, playbook3.yml```

Организует мониторинг репликации MASTER -> SLAVE:
--------------
* добавляет пользователя для мониторинга MySQL
* добавляет 1 контейнер **mysqld-exporter** для мониторинга обоих MASTER и SLAVE,
* добавляет контейнер **Prometheus** и запускает с подготовленным конфигом,
* добавляет контейнер **Graphana**,
* на **Graphana** подключает **Prometheus** в качестве источника данных и
* добавляет [дашбоард для MySQL](https://grafana.com/api/dashboards/21821/revisions/1/download)

Тестирование:
------------
для автоматизации развёртывания и тестирования работы playbook'а использется [GitHub Actions](https://github.com/features/actions).
