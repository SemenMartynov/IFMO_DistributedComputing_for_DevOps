# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

```
# NetBox Deployment Project

This project provides a structured approach to deploying [NetBox](https://github.com/netbox-community/netbox), an open-source web-based tool for managing and documenting computer networks. The deployment process is automated using Ansible playbooks and Docker Compose, ensuring a streamlined setup and configuration experience.

The project includes:
- **Ansible Playbooks**: For installing Docker and managing the deployment of NetBox.
- **Configuration Files**: Customizable settings for NetBox, including LDAP integration, logging, and plugins.
- **Environment Variables**: Predefined `.env` files for configuring services like PostgreSQL, Redis, and NetBox itself.

---

## Project Structure

```
.
├── LICENSE
├── README.md
├── install-docker.yml          # Ansible playbook to install Docker and copy the NetBox project folder
├── inventory                   # Inventory file for Ansible (not included in this snippet)
├── netbox                      # Main NetBox project folder
│   ├── configuration            # Configuration files for NetBox
│   │   ├── configuration.py     # Main NetBox configuration
│   │   ├── extra.py             # Additional custom configurations
│   │   ├── ldap                 # LDAP-related configurations
│   │   │   ├── extra.py         # Extra LDAP settings
│   │   │   └── ldap_config.py   # LDAP configuration file
│   │   ├── logging.py           # Logging settings
│   │   └── plugins.py           # Plugin configurations
│   ├── docker-compose.yml       # Docker Compose file for launching NetBox services
│   └── env                      # Environment variable files
│       ├── netbox.env           # NetBox-specific environment variables
│       ├── postgres.env         # PostgreSQL database configuration
│       ├── redis-cache.env      # Redis cache configuration
│       └── redis.env            # Redis configuration
└── run-docker.yml               # Ansible playbook to start NetBox using Docker Compose
```

---

## Installation and Deployment

### Prerequisites
1. Ensure that Ansible is installed on your control machine.
2. Update the `inventory` file with the target host(s) where NetBox will be deployed.

### Steps

1. **Install Docker**  
   Run the following command to install Docker on the target host and copy the `netbox` project folder:
   ```bash
   ansible-playbook -i inventory install-docker.yml
   ```

2. **Start NetBox Services**  
   Use the `run-docker.yml` playbook to launch the NetBox services using Docker Compose:
   ```bash
   ansible-playbook -i inventory run-docker.yml
   ```

3. **Verify Deployment**  
   Once the playbooks complete successfully, the NetBox services will be up and running.

---

## Accessing the NetBox UI

You can access the NetBox web interface at the following address:  
[http://192.168.0.105:8003/](http://192.168.0.105:8003/)

Default login credentials are typically configured in the `netbox.env` file. Ensure you update them as needed for security.

---

## Notes

- Modify the configuration files under `netbox/configuration` to suit your specific requirements.
- Update the `.env` files in the `netbox/env` directory to customize service settings such as database credentials, Redis configurations, and more.
- Ensure that the IP address `192.168.0.105` matches the actual IP or hostname of your deployment server.

For further details about NetBox, refer to the official documentation: [https://netbox.readthedocs.io/](https://netbox.readthedocs.io/)
```