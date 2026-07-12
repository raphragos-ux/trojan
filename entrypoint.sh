#!/bin/bash
set -e

# Gumawa ng SSL cert
openssl req -x509 -newkey rsa:4096 -keyout /app/key.key -out /app/cert.crt -days 3650 -nodes -subj "/CN=trojan-server"

# Gamitin ang PORT mula sa GCP
sed -i "s/listen 8080;/listen $PORT;/" /etc/nginx/nginx.conf

# Siguraduhing may sagot sa Health Check
echo "OK" > /usr/share/nginx/html/index.html

# Simulan ang Nginx
nginx

# Simulan ang Trojan
exec trojan -c /app/config.json
