# Sukhikh Matvei

1. На сервере должен быть установлен ansible, sshpass, docker и docker-compose

2. Склонировать репозиторий к себе на ПК

3. Запустить установку докера:
ansible-playbook -i inventory.ini dockerinstplaybook.yml --ask-pass --ask-become-pass

4. Запустить ansible-playbook командой:
ansible-playbook -i inventory.ini playbook.yml --ask-pass --ask-become-pass

5. Запустить ansible-playbook для создания реплики командой:
ansible-playbook -i inventory.ini playbook2.yml --ask-pass --ask-become-pass

6. Проверить можно запустив ansible-playbook'и командами:
ansible-playbook -i inventory.ini playbook2test.yml --ask-pass --ask-become-pass
ansible-playbook -i inventory.ini playbook2aftertest.yml --ask-pass --ask-become-pass
