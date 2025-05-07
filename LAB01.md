# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

# Лабораторная работа №1


Требования:
-----------
* На управлямом сервере установлена Ubuntu версии 22.04,
* сервер **carrier** внесён в inventory: **inventory.yml** со всеми полями:
  * ansible_host: 192.168.XXX.XXX
  * ansible_user: XXXXXXXX
  * ansible_password: XXXXXXXX
  * ansible_become_method: sudo
  * ansible_become_pass: XXXXXXXX
* на сервере **carrier** заведён пользователь из **inventory.yml**:
  * ```useradd someuser```
* и он добавлен в группу sudo:
  * ```usermod -aG sudo someuser```,
* с сервера есть доступ в Интернет.

Как запустить:
--------------
```ansible-playbook --inventory carrier, playbook1.yml```

Что выполняет:
--------------
* Устанавливает и запускает **docker** c docker.com

* Создаёт две сети для **docker**:
  * внутреннюю для взаимодействия только между контейнерами
  * "внешнюю".

* Загружает, устанавливает и запускает два контейнера:
  * **mysql:8.4**. Для пользователя MySQL используется случано сгенерированный пароль.
  * **wordpress**. Для контейнера wordpress "проброшен" 80 порт.

Для получения сертификата **letsencrypt** 
-----------------------------------------
нужен "реальный" (маршрутизируемый в сети Интернет) IP-адрес, у меня его нет, поэтому HTTPS не реализован. но у меня есть две идеи, как это можно сделать:
  * Контейнер wordpress использует apache, у в его составе есть штатный модуль [mod_md](https://httpd.apache.org/docs/2.4/mod/mod_md.html),
который автоматизирует работу по получению и продлению сертификатов letsencrypt.
  * Или использовать готовые решения, например, https://github.com/systemli/ansible-role-letsencrypt .

Тестирование:
------------
для автоматизации развёртывания и тестирования работы playbook'а использется [GitHub Actions](https://github.com/features/actions).
