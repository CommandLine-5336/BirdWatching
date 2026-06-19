#!/bin/bash
set -e

apt-get update
apt-get install -y nginx python3-pip python3-venv 

cp /vagrant/provisioning/web/nginx-web.conf /etc/nginx/sites-available/flask.conf
ln -sf /etc/nginx/sites-available/flask.conf /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

mkdir -p /opt/flask-app
python3 -m venv /opt/flask-app/.venv

/opt/flask-app/.venv/bin/pip install flask
/opt/flask-app/.venv/bin/python3 -m flask --version

systemctl restart nginx