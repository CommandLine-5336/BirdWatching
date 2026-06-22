#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update -y && apt-get install python3 python3-venv -y
python3 -m venv /opt/venv
/opt/venv/bin/pip install Flask gunicorn pymysql
cp /vagrant/configs/birdwatcher.service /etc/systemd/system/birdwatcher.service
systemctl daemon-reload && systemctl enable --now birdwatcher