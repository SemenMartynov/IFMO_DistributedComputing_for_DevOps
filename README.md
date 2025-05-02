# WordSquid 🐙

**WordSquid** is an automated deployment system for a MySQL cluster with master-slave replication, optimized WordPress setup, and a monitoring stack based on **Prometheus** and **Grafana** with preloaded dashboards.

It uses **Ansible** and **Vagrant** to fully automate the provisioning of a local virtual infrastructure.

## 🚀 What's Included

- 🗄️ **MySQL master-slave replication**
- 📰 **WordPress** configured to use external MySQL
- 📈 **Prometheus** for metrics collection
- 📊 **Grafana** with pre-provisioned dashboards
- 🧪 Local environment using **VirtualBox** and **Vagrant**

## 🧰 Prerequisites

Make sure you have the following installed:

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://developer.hashicorp.com/vagrant/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## 🛠️ Quick Start

### 1. Start the Virtual Machines

```bash
vagrant up
```

### 2. Run Ansible Playbooks

```bash
ansible-playbook homework-3.yaml
```

### 3. Access the WordPress Site
Open your web browser and navigate to:

```
http://192.168.0.15
```

### 4. Access the Grafana Dashboard
Open your web browser and navigate to:

```
http://192.168.0.27:3000
```
- **Username:** admin
- **Password:** admin

### 5. Access the Prometheus Dashboard
Open your web browser and navigate to:

```
http://192.168.0.27:9090
```

### 6. To Stop the Virtual Machines
```bash
vagrant halt
```

### 7. To Destroy
```bash
vagrant destroy
```

### 8. To SSH into the VMs
```bash
vagrant ssh <vm_name>
```
