#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update -y && apt-get install mariadb-server -y

cp /vagrant/configs/ningx.conf /etc/ningx/sites-available/default

systemctl restart ningx
