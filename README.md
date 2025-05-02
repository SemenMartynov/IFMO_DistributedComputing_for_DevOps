# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

## ИТМО Распределенные Вычисления для DevOps

Второе домашнее задание по курсу "Распределенные Вычисления" ИТМО для магистратуры "DevOps Инженер облачных сервисов".

## Задача
Для инстанса WordPress заменить БД на кластер и обеспечить синхронизацию данных.

## Описание решения
Предполагается, что плейбук запускается после настройки одной машины с nginx+wordpress+mysql.

В рамках решения:
- Создаем с помощью Vagrant три виртуальные машины:
  - Одну для приложения с nginx и WordPress
  - Две для кластера MySQL (master и slave)
- Создаем дамп базы данных и останавливаем старый контейнер MySQL
- Запускаем кластер MySQL в конфигурации master-slave, настраиваем репликацию
- Восстанавливаем дамп на master-сервере и проверяем репликацию на slave

## Запуск 
```bash
vagrant up
cd ansible/
ansible-playbook -i inventory.ini playbook.yml --vault-password-file test_vault_pass.txt
