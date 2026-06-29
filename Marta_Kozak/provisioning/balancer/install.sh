#!/bin/bash
set -e

apt-get update
apt-get install -y nginx

echo "${WEB01_IP} web01" >>/etc/hosts
echo "${WEB02_IP} web02" >>/etc/hosts

cp /vagrant/provisioning/balancer/nginx-lb.conf /etc/nginx/sites-available/balancer.conf

ln -sf /etc/nginx/sites-available/balancer.conf /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

systemctl restart nginx
