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
        alias /home/vagrant/Bird1/static/;
    }     

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF
git clone https://github.com/Derankatinum/Bird1.git
cd Bird1
sudo apt update 
sudo apt install python3-venv -y
python3 -m venv .venv
source .venv/bin/activate
pip install flask 
chmod +x /home/vagrant/Bird1
chmod +x /home/vagrant/Bird1/static
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl start nginx
nohup python3 hello.py &
