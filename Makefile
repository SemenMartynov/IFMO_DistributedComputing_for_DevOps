ANSIBLE=ansible-playbook
INVENTORY=inventory.yml

docker-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/docker/install.yml

docker-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/docker/remove.yml

hw1-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw1/install.yml

hw1-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw1/remove.yml

hw2-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw2/install.yml

hw2-test:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw2/test.yml

hw2-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw2/remove.yml

hw3-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw3/install.yml

hw3-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw3/remove.yml

hw4-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/install.yml

hw4-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/remove.yml

hw4-etcd-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/etcd/install.yml

hw4-etcd-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/etcd/remove.yml

hw4-patroni-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/patroni/install.yml

hw4-patroni-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/patroni/remove.yml

hw4-haproxy-install:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/haproxy/install.yml

hw4-haproxy-remove:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/haproxy/remove.yml

hw4-monitoring-restart:
	$(ANSIBLE) -i $(INVENTORY) playbooks/hw4/monitoring/restart.yml
