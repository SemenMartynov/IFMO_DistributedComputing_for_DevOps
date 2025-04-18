#!/bin/bash

echo "Создание пользователя репликации в мастер бд"

mysql -uroot -p"$mysql_root_password" -e "
  CREATE USER '{{ replica_user }}'@'%' identified by '{{ replica_password }}';
  GRANT REPLICATION SLAVE ON *.* TO '{{ replica_user }}'@'%';
  FLUSH PRIVILEGES;
  FLUSH TABLES WITH READ LOCK;
"
