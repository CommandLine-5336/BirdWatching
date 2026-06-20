#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -y && apt-get install nginx -y

cat << 'EOF' > /etc/nginx/sites-available/default
upstream web_servers {
    server 192.168.56.11:80;
    server 192.168.56.12:80;
}
server {
    listen 80;
    location / {
        proxy_pass http://web_servers;
    }
}
EOF
systemctl restart nginx
