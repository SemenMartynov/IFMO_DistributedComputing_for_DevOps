# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

## Развёртывание WordPress с помощью Ansible и Docker

Домашнее заданиее №1 по дисциплине «Распределённые вычисления» (ИТМО) показывает, как с помощью `Ansible` можно быстро и легко развернуть три контейнера (`WordPress`, `MySQL`, `Nginx`) для создания готового к использованию веб-сайта, например, [http://84.252.142.110:8080](http://84.252.142.110:8080) на основе `WordPress`.

### Обзор проекта

Основная идея - использовать `Ansible` для:
1. Установки и настройки `Docker`, `Docker Compose`
2. Подготовки `MySQL`
3. Развёртывания `WordPress` и конфигурации `Nginx`

В результате, после единственной команды `Ansible`, пользователь получает функциональный `WordPress`-сайт по адресу:

```
http://localhost:8080
```

### Структура репозитория

Ниже приведены главные элементы проекта и их назначение:

- **`requirements.yml`**
  - Содержит перечень необходимых `Ansible`-коллекций (например, `community.docker`), позволяющих управлять контейнерами через `Ansible`
  
- **`inventory/hosts.ini`**
  - Указывает локальный хост `127.0.0.1` с типом подключения `ansible_connection=local`
  - Содержит установку интерпретатора `Python3` для `Ansible` (`ansible_python_interpreter=/usr/bin/python3`)

- **`group_vars/` и `host_vars/`**
  - Хранят глобальные переменные для разных окружений (БД, учётные данные `WordPress` и т.п.), например:
    - `database_name: wordpress_db`
    - `database_user: wordpress_user`
    - `database_password: wordpress_password`
    - `wordpress_admin_user: admin`
    - `wordpress_admin_password: admin_password`
    - `wordpress_site_url: "http://localhost:8080"`

- **`site.yml`**
  - Главный `Ansible`-плейбук, который последовательно вызывает роли:
    1. `docker_setup`
    2. `db_setup`
    3. `wordpress_setup`

- **`roles/docker_setup/`**
  - Отвечает за:
    1. Установку `Docker` и запуск соответствующего сервиса
    2. Скачивание и установку `Docker Compose` из GitHub (в зависимости от архитектуры и ОС)
    3. Генерацию файла `docker-compose.yml` из шаблона `docker-compose.yml.j2`
    4. Запуск контейнеров (`MySQL`, `WordPress`, `Nginx`)
    5. Создание специальной сети `wordpress-network`

- **`roles/db_setup/`**
  - Ожидает запуска `MySQL` (порт 3306) перед выполнением дальнейших задач
  - Опционально может хранить дополнительные скрипты или шаблоны для настройки базы данных

- **`roles/wordpress_setup/`**
  - Копирует файл `wp-config.php` (из шаблона `wp-config.php.j2`) в рабочую директорию `WordPress`
  - Настраивает подключение к `MySQL`, префикс таблиц, кодировку и другие параметры `WordPress`
  - Завершает настройку, выводя сообщение о готовности среды

- **`nginx.conf`**  
  - Конфигурация `Nginx`, перенаправляющая PHP-запросы к контейнеру `WordPress (php-fpm)`, а статические файлы (`HTML`/`CSS`/`JS`/`изображения`) отдаёт непосредственно из `/var/www/html`

### Скриншоты

<details>
<summary><b>Этап 1: Состояние Docker-контейнеров после развёртывания</b></summary>

   Отображение результата выполнения команды `docker ps`. Видны работающие контейнеры:
   - `wordpress_nginx` (порт 8080)
   - `wordpress_app` (php-fpm, порт 9000)
   - `wordpress_db` (MySQL, порт 3306)
   
   Все сервисы в рамках общей сети `wordpress-network` успешно запущены и работают в соответствии с конфигурацией `docker-compose.yml`.

![](/screenshots/screenshot_04.png)

</details>

<details>
<summary><b>Этап 2: Начальный экран установки WordPress</b></summary>

   На этом этапе пользователю выводится экран выбора языка интерфейса. Это показывает, что контейнеры успешно развернуты и `WordPress` доступен по указанному адресу.
   
   Этот скриншот подтверждает корректную работу стека `Nginx` + `PHP-FPM` + `MySQL` и готовность к первичной настройке.

![](/screenshots/screenshot_01.png)

</details>

<details>
<summary><b>Этап 3: Консоль администратора WordPress</b></summary>

   На этом этапе пользователю выводится интерфейс административной панели (`wp-admin`) `WordPress`. Этот скриншот подтверждает успешное подключение к базе данных, генерацию `wp-config.php`, сохранение настроек и возможность полноценного управления веб-сайтом.

![](/screenshots/screenshot_03.png)

</details>

<details>
<summary><b>Этап 4: Отображение главной страницы WordPress</b></summary>

   На этом этапе показана публичная часть веб-сайта, на которой по умолчанию опубликована запись "Привет, мир!" Этот скриншот подтверждает успешную интеграцию `WordPress` с веб-сервером `Nginx` и доступность веб-сайта по `HTTP`.

![](/screenshots/screenshot_02.png)

</details>

### Шаги установки и запуска

1. **Клонирование репозитория**

   ```bash
   git clone https://github.com/DmitryFedoroff/IFMO_DistributedComputing_for_DevOps.git
   ```

2. **Установка зависимостей Ansible**

   ```bash
   ansible-galaxy collection install -r requirements.yml
   ```

   Убедись, что у тебя корректно установлен `Ansible`:

   ```bash
   ansible --version
   ```

3. **Запуск главного плейбука**

   ```bash
   ansible-playbook -i inventory/hosts.ini site.yml
   ```

   - При первом запуске роли `docker_setup` установят `Docker` (если он отсутствует), скачают `Docker Compose` и создадут файл `docker-compose.yml`
   - Затем `Ansible` поднимет контейнеры
   - Роль `db_setup` дождётся, пока `MySQL` будет доступен по порту `3306`
   - Роль `wordpress_setup` настроит `wp-config.php` и выведет финальное сообщение при успешном завершении

4. **Проверка работы**
   - Зайди по адресу [http://localhost:8080](http://localhost:8080).
   - Убедись, что `WordPress` доступен и готов к первоначальной настройке (или авторизации, если уже настроен).

### Структура Docker-компоновки

Шаблон `docker-compose.yml.j2` описывает три сервиса:

- **db (MySQL 5.7)**
  - Проброшенный порт: `3306:3306`
  - Переменные окружения для инициализации: `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD`
  - Хранение данных в томе `db_data`

- **wordpress (PHP-FPM)**
  - Образ: `wordpress:php8.1-fpm`
  - Общий том `wordpress_data`, где лежат файлы `WordPress`
  - Переменные окружения для подключения к `MySQL`

- **nginx**
  - Прослушивает порт `80` внутри контейнера, проброшен на `8080:80`
  - Шаблон конфигурации `nginx.conf` монтируется в контейнер
  - Обслуживает `WordPress`, перенаправляя `.php` файлы на сервис `wordpress`

Все контейнеры объединены в одной сети `wordpress-network`

### Частые проблемы и их решения

1. **Порт 8080 уже занят**
   - Измени настройку проброса порта в `docker-compose.yml.j2` (например, `8081:80`) и перезапусти плейбук:

     ```bash
     ansible-playbook -i inventory/hosts.ini site.yml
     ```

2. **Установка Docker Compose не удалась**
   - Убедись, что у тебя есть доступ к `GitHub`, когда роль `docker_setup` пытается скачать бинарник `Docker Compose`.
   - Если `Docker Compose` уже установлен, `Ansible` может пропустить шаг скачивания.

3. **MySQL не отвечает**
   - Роль `db_setup` ждёт появления `3306` порта. Если время ожидания истекает, проверь логи контейнера:

     ```bash
     docker logs wordpress_db
     ```

   - Убедись, что переменные `MYSQL_ROOT_PASSWORD`, `MYSQL_USER`, `MYSQL_PASSWORD` корректны.

4. **WordPress выдаёт ошибку 502 или недоступен**
   - Проверь логи `Nginx`:

     ```bash
     docker logs wordpress_nginx
     ```

   - Убедись, что контейнер `wordpress_app` (PHP-FPM) запущен и видит `MySQL`.

### Управление и дальнейшая разработка

- **Обновление**
  
  При изменении шаблонов или конфигураций перезапусти команду:

  ```bash
  ansible-playbook -i inventory/hosts.ini site.yml
  ```

  Роль `community.docker.docker_compose` сравнит конфигурацию и, если нужно, пересоздаст контейнеры.

- **Остановка и удаление**
  
  Чтобы остановить и удалить контейнеры вместе с томами:

  ```bash
  docker-compose down -v
  ```

  При этом данные в базах будут потеряны.

### Контакты

- **Автор**: Дмитрий Федоров
- **Эл. почта**: [fedoroffx@gmail.com](mailto:fedoroffx@gmail.com)
- **Telegram**: [https://t.me/dmitryfedoroff](https://t.me/dmitryfedoroff) 