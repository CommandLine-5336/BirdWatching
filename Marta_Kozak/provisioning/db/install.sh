#!/bin/bash
set -e

apt-get update
apt-get install -y mariadb-server

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'${DB_ALLOWED_HOST}' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'${DB_ALLOWED_HOST}';"
mysql -e "FLUSH PRIVILEGES;"

echo "Database ${DB_NAME} has been successfully created!"
