# Distributed Computing
### Lab 1
Для начала развертывания необходимо заполнить inventory файл.
После чего выполнить команду 

`ansible-playbook -i inventory.ini playbook_lab1.yaml`

После развертывания на машине будет установлен Wordpress, работающий через ssl.
Для корректного отображения сайта необходимо будет законичить установку через браузер.

### Lab 2

Для начала работы необходимо заполнить `inventory_lab2.ini`
После заполнения выполнить команду - `ansible-playbook -i inventory_lab2.ini playbook_lab2.yaml`