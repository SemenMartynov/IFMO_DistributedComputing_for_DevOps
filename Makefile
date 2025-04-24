ANSIBLE=ansible-playbook
INVENTORY=inventory.yml
ENV_FILE=.env

define LOAD_ENV
@export $(shell grep -v '^#' $(ENV_FILE) | xargs)
endef

install-deps:
	ansible-galaxy collection install community.docker

ping:
	ansible -i $(INVENTORY) all -m ping

init:
	$(LOAD_ENV) && echo "Env vars loaded"

hw1:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw1.yml

hw2:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw2.yml

check:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/check_cluster.yml

clean:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/cleanup.yml
