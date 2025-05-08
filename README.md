# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

## ИТМО Распределенные Вычисления для DevOps

Третье домашнее задание по курсу "Распределенные Вычисления" ИТМО для магистратуры "DevOps Инженер облачных сервисов".

## Задача
Добавить мониторниг для кластера MySQL

## Описание решения

В рамках решения:
- Создаем с помощью Vagrant три виртуальные машины:
  - Одну для приложения с nginx, WordPress, MySQL 
  - Две для кластера MySQL (master и slave)
- Создаем дамп базы данных и останавливаем старый контейнер MySQL на первой машине
- Запускаем кластер MySQL в конфигурации master-slave, настраиваем репликацию
- Восстанавливаем дамп на master-сервере и проверяем репликацию на slave
- Запускаем сервер Prometheus на первой машине + node exporter
- Запускаем Mysql exporter для master и slave
- Запускаем и настраиваем Grafana (дашборд для node exporter и Mysql exporter)

## Запуск 
```bash
vagrant up
ansible-playbook -i inventory.ini playbook-0.yml
ansible-playbook -i inventory.ini playbook-1.yml
ansible-playbook -i inventory.ini playbook-2.yml
