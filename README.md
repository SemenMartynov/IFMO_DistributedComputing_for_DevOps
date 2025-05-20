# Лабораторная работа по распределённым системам (ITMO / Яндекс.Практикум)

Репозиторий создан для изучения архитектуры распределённых систем с использованием облачной платформы Yandex Cloud. В проекте разворачивается инфраструктура для системы с балансировкой нагрузки между мастер- и слейв-серверами PostgreSQL.

## 🛠 Технологии
- **Инфраструктура**: Terraform + Yandex Cloud
- **Конфигурация**: Ansible
- **СУБД**: PostgreSQL (мастер-слейв репликация)

## 🚀 Быстрый старт

### 1. Предварительные требования
- Аккаунт в [Yandex Cloud](https://cloud.yandex.ru/)
- Установленный [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (1.11.3)
- Установленный [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) (2.15.13)
- Доступ к YC CLI (`yc`)

### 2. Настройка переменных
перейдите в папку infrs
```bash

cd infra
```

Скопируйте шаблон переменных и укажите свои значения:
```bash

cp terraform_exp.tfvars terraform.tfvars
nano terraform.tfvars  # отредактируйте файл
```

Или сразу создайте папку secrets, скопируйте и отредактируйте файл там
```bash
mkdir secrets
cp terraform_exp.tfvars secrets/terraform.tfvars
nano secrets/terraform.tfvars
```

### 3. Развёртывание инфраструктуры
```bash

terraform init
terraform apply -auto-approve # или terraform apply --var-file="secrets/terraform.tfvars" -auto-approve
```
После выполнения:
- В `infra/secrets/vm_ips.json` появятся IP-адреса ВМ
- Автоматически генерируется инвентарный файл для Ansible

4. Настройка серверов через Ansible
```bash

cd ansible/
ansible-playbook -i inventory.yml playbook.yml

📂 Структура репозитория
├── infra/                   # Terraform-конфигурация
│   ├── main.tf              # Основная конфигурация
│   ├── variables.tf         # Объявление переменных
│   ├── outputs.tf           # Выходные IP-адреса
│   └── terraform_exp.tfvars # Персональные переменные
├── ansible/
│   ├── inventory.yml        # Автогенерируемый инвентарь
│   ├── playbook.yml         # Основной плейбук
│   └── roles/               # Роли для настройки
│       ├── postgres_master/
│       ├── postgres_slave/
│       └── app_server/
└── README.md                # Этот файл
```

🔐 Безопасность
- Все sensitive-данные (токены, пароли) исключены из репозитория через .gitignore
- Для доступа к ВМ используются только SSH-ключи

📝 Лицензия
MIT License. Подробнее в файле LICENSE.

> **Note**
> 
> Проект разработан в рамках учебного курса "Распределённые системы" в Университете ИТМО при поддержке Яндекс.Практикума.


### Дополнительные рекомендации:
1. Добавьте `.gitignore` с исключением:
   ```gitignore
   *.tfstate
   *.tfvars
   secrets/
   .terraform/

2. Для автоматической генерации Ansible inventory добавьте в outputs.tf:

    ``` terraform
    output "ansible_inventory" {
      value = templatefile("${path.module}/templates/inventory.tpl", {
        app_ip    = yandex_compute_instance.app.network_interface.0.ip_address,
        master_ip = yandex_compute_instance.pg_master.network_interface.0.ip_address,
        slave_ip  = yandex_compute_instance.pg_slave.network_interface.0.ip_address
      })
    }
    ```

3. Пример шаблона inventory.tpl:

    ```ansible
    ini
    [app]
    app_server ansible_host=${app_ip}
    
    [db_master]
    pg_master ansible_host=${master_ip}
    
    [db_slave]
    pg_slave ansible_host=${slave_ip}
    
    [all:vars]
    ansible_user=ubuntu
    ansible_ssh_private_key_file=~/.ssh/id_rsa
    ```