# Sukhikh Matvei

1. На сервере должен быть установлен ansible и sshpass.

2. Склонировать репозиторий к себе на ПК

3. Запустить ansible-playbook командой:
ansible-playbook -i inventory.ini playbook.yml --ask-pass --ask-become-pass
