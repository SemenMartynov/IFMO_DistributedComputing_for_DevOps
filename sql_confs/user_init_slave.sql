CHANGE MASTER TO 
MASTER_HOST = 'wp_db_master',
MASTER_PORT=3306,
MASTER_USER='{{ replica_user }}',
MASTER_PASSWORD='password',
MASTER_LOG_FILE='{{ master_log_file }}',
start slave;
