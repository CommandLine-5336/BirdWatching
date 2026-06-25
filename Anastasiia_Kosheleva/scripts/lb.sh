#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update -y && apt-get install mariadb-server -y

cp /vagrant/configs/nginx.conf /etc/nginx/sites-available/default

systemctl restart nginx
