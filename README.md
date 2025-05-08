# IFMO_DistributedComputing_for_DevOps
Distributed Computing course for DevOps 2025

Task 1
Fedor Kuzminov

### Before run
`touch vault_password.txt`<br>
`echo $VAULT_PASS >> vault_password.txt`

### Now we need to generate new secrets:
`ansible-vault encrypt_string '<wordpress_password>'`<br>
`ansible-vault encrypt_string '<wordpress_user>'`

And add the generated strings to the `./wordpress/vars/main.yml` file:

The service is available: http://158.160.108.161

