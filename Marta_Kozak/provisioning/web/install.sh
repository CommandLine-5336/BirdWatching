#!/bin/bash
set -e

apt-get update
apt-get install -y nginx python3-pip python3-venv wget gnupg

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | tee -a /etc/apt/sources.list.d/trivy.list

apt-get update
apt-get install -y trivy

cp /vagrant/provisioning/web/nginx-web.conf /etc/nginx/sites-available/flask.conf
ln -sf /etc/nginx/sites-available/flask.conf /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

mkdir -p /opt/flask-app
cp -r /vagrant/app/* /opt/flask-app/

python3 -m venv /opt/flask-app/.venv
/opt/flask-app/.venv/bin/pip install flask

cp /vagrant/provisioning/web/flask.service /etc/systemd/system/

systemctl daemon-reload
systemctl enable flask
systemctl start flask
systemctl restart nginx
