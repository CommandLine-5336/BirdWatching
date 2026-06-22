#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo chmod +x /home/vagrant

cat << 'EOF' > "/etc/nginx/sites-enabled/default"
upstream web_app {
    server 192.168.1.11:80;
    server 192.168.1.12:80;
}

server {
    listen 80;

    location /static/ {
        proxy_pass http://web_app;
        proxy_set_header Host $host;
    }

    location / {
        proxy_pass http://web_app;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF
sudo systemctl reload nginx
