#!/bin/bash
echo ">>> Frontend starting..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install python3 python3-pip python3-venv -y

APP_DIR="/opt/birdwatcher"
cd $APP_DIR
python3 -m venv venv
./venv/bin/pip install Flask gunicorn

cat << 'EOF' > /etc/systemd/system/birdwatcher.service
[Unit]
Description=Birdwatcher Frontend Service
After=network.target

[Service]
User=root
WorkingDirectory=/opt/birdwatcher
Environment="PATH=/opt/birdwatcher/venv/bin"
ExecStart=/opt/birdwatcher/venv/bin/gunicorn --workers 2 --bind 0.0.0.0:5000 app:app

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start birdwatcher
systemctl enable birdwatcher
