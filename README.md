# DevOps Homework 1
## Setup MySQL Server and WordPress on virtual machine

#### Prerequisites
- VirtualBox installed
- Vagrant installed
- Ansible installed

#### Steps
1. Run the following command to start the virtual machine:
```bash
vagrant up
```
2. Run the following command to provision the virtual machine:
```bash
ansible-playbook site.yml
```
3. After the provisioning is complete, you can access the WordPress site by navigating to `http://127.0.0.15` in your web browser.
4. To stop the virtual machine, run the following command:
```bash
vagrant halt
```
5. To destroy the virtual machine, run the following command:
```bash
vagrant destroy
```
