#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install python3 python3-pip python3-venv psycopg2-binary -y
APP_DIR="/opt/birdwatcher"
mkdir -p $APP_DIR
cd $APP_DIR || exit

python3 -m venv venv
./venv/bin/pip install Flask gunicorn boto3 psycopg2-binary

cp /vagrant/configs/birdwatcher.service /etc/systemd/system/birdwatcher.service

systemctl daemon-reload && systemctl restart birdwatcher && systemctl enable birdwatcher
