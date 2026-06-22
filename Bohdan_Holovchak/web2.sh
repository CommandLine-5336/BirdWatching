#!/bin/bash
sudo apt update
sudo apt install nginx -y
cat << 'EOF' > "/etc/nginx/sites-enabled/default"
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    server_name _;

    location /static/ {
        alias /home/vagrant/Bird2/static/;
    }     

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF
git clone https://github.com/Derankatinum/Bird2.git
cd Bird2
sudo apt update 
sudo apt install python3-venv -y
python3 -m venv .venv
source .venv/bin/activate
pip install flask 
chmod +x /home/vagrant/Bird2
chmod +x /home/vagrant/Bird2/static
sudo cat << 'EOF' > /etc/systemd/system/bird2.service
[Unit]
Description=Flask Bird2 Application
After=network.target

[Service]
User=vagrant
WorkingDirectory=/home/vagrant/Bird2
ExecStart=/home/vagrant/Bird2/.venv/bin/python hello.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl start bird2
sudo systemctl enable bird2
sudo systemctl reload nginx