-- mysql-check user haproxy_check
CREATE USER IF NOT EXISTS 'haproxy_check'@'%' IDENTIFIED BY '';
-- mysql-exporter user metrics
CREATE USER 'exporter'@'%' IDENTIFIED BY 'exporter_password';
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';