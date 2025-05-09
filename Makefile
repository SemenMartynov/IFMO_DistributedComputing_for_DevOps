up-all: docker docker-up-wordpress monitoring

# установить докер
docker:
	ansible-playbook playbooks/docker.yml

# с помощью docker-compose файла поднять Wordpress и mysql
docker-up-wordpress:
	ansible-playbook playbooks/docker-up-wordpress.yml

# мониторинг
monitoring:
	ansible-playbook playbooks/monitoring.yml

lint:
	ansible-lint --parseable