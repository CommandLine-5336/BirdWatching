#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -y && apt-get install nginx python3 python3-venv -y

python3 -m venv /opt/venv
/opt/venv/bin/pip install Flask gunicorn pymysql

cat << 'EOF' >/etc/nginx/sites-available/default
server {
    listen 80;
    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
    }
}
EOF
systemctl restart nginx

cat << 'EOF' >/etc/systemd/system/birdwatcher.service
[Unit]
Description=Birdwatcher App
[Service]
User=root
WorkingDirectory=/opt/birdwatcher
Environment="PATH=/opt/venv/bin"
ExecStart=/opt/venv/bin/gunicorn --workers 2 --bind 127.0.0.1:5000 app:app
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload && systemctl restart birdwatcher && systemctl enable birdwatcher
