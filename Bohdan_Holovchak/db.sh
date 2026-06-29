#!/bin/bash
sudo apt-get update -y
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.71.2
sudo apt install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS BirdwatchingApp;"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON BirdwatchingApp.* TO 'USERNAME'@'%' IDENTIFIED BY 'PASSWORD';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

sudo mysql -u USERNAME -pPASSWORD -e "USE BirdwatchingApp;
    CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    location VARCHAR(255)
);"
