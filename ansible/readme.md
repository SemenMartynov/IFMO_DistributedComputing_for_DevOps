1. запуск мастера +
2. создать пользователя для реплики +
3. скопировать конфиги мастера +
4. рестарт мастера +
5. запуск слейва +
6. создать бекап со слейва +
7. скопировать конфиги слейва
8. создать standby.signal
9. рестарт слейва


Master
pg_hba.conf
echo "host replication repl_user 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

postgresql.conf
echo "wal_level = replica" >> /var/lib/postgresql/data/postgresql.conf
echo "max_wal_senders = 10" >> /var/lib/postgresql/data/postgresql.conf
echo "wal_keep_size = 1GB" >> /var/lib/postgresql/data/postgresql.conf


Slave

pg_basebackup -h postgres-master -U repl_user -D /var/lib/postgresql/data -P -R -X stream -C -S pg_replica_slot

touch /var/lib/postgresql/data/standby.signal

echo "primary_conninfo = 'host=postgres-master port=5432 user=repl_user password=secret'" >> /var/lib/postgresql/data/postgresql.auto.conf
echo "primary_slot_name = 'pg_replica_slot'" >> /var/lib/postgresql/data/postgresql.auto.conf

chown postgres:postgres -R /var/lib/postgresql/data/

pg_ctl start -D /var/lib/postgresql/data


Ansible

ansible-playbook install_docker_playbook.yml -l all
ansible-playbook install_py_modules.yml -l all
ansible-playbook run_application_playbook.yml -l app