ANSIBLE=ansible-playbook
INVENTORY=inventory.yml
ENV_FILE=.env

define LOAD_ENV
@export $(shell grep -v '^#' $(ENV_FILE) | xargs)
endef

init:
	$(LOAD_ENV) && echo "Env vars loaded"

docker-install:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/docker/install.yml

docker-remove:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/docker/remove.yml

hw1-install:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw1/install.yml

hw1-remove:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw1/remove.yml

hw2-install:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw2/install.yml

hw2-test:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw2/test.yml

hw2-remove:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw2/remove.yml

hw3-install:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw3/install.yml

hw3-remove:
	$(LOAD_ENV) && $(ANSIBLE) -i $(INVENTORY) playbooks/hw3/remove.yml
