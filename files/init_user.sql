-- mysql-check user haproxy_check
CREATE USER IF NOT EXISTS 'haproxy_check'@'%' IDENTIFIED BY '';

-- mysql-exporter user metrics
CREATE USER IF NOT EXISTS 'exporter'@'%' IDENTIFIED BY 'biengePh4e';
GRANT PROCESS, REPLICATION CLIENT, SELECT, SLAVE MONITOR ON *.* TO 'exporter'@'%';
FLUSH PRIVILEGES;
