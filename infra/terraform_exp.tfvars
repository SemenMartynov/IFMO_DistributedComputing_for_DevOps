platform_id    = "standard-v2"
cores          = 2
memory         = 1
disk_size      = 30
core_fraction  = "5"
disk_type      = "network-hdd"
ssh_public_key = "ssh-ed25519 example"
image_family   = "toolbox"
zone           = "ru-central1-a"
folder_id = "example"
cloud_id = "example"

# vpc
vpc_name    = "dist-vps"
sg_db_name  = "dist-db-sg"
sg_app_name = "dist-app-sg"

# vm: db_1
vm_db_1_name = "master-db"

# vm: db_2
vm_db_2_name = "slave-db"

# vm: app_1
vm_app_1_name = "app"

