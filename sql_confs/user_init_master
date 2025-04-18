CREATE USER '{{ replica_user }}'@'%' identified by 'password';
GRANT REPLICATION SLAVE ON *.* TO '{{ replica_user }}'@'%';
flush privileges;
