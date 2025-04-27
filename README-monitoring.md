# Мониторинг кластера MySQL

## Обзор

Эта система мониторинга предоставляет возможность отслеживать производительность и состояние кластера MySQL с использованием набора инструментов: cAdvisor, Prometheus и Grafana.

## Компоненты

- **cAdvisor**: Анализирует использование ресурсов и производительность контейнеров Docker.
- **Prometheus**: Система сбора и хранения метрик с временными рядами.
- **Grafana**: Платформа для визуализации метрик и создания информационных панелей.

Подробнее о компонентах:
- [cAdvisor](https://github.com/google/cadvisor)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)

## Установка и настройка

Мониторинг настраивается с помощью Ansible Playbook:

```bash
ansible-playbook monitor-cluster-playbook.yml
```

## Доступ к интерфейсам мониторинга

После установки вы можете получить доступ к интерфейсам:

- cAdvisor: `http://wordpress_server_ip:8080`
- Prometheus: `http://wordpress_server_ip:9090`
- Grafana: `http://wordpress_server_ip:9100`

Логин и пароль для Grafana указаны в файле `.env`.
