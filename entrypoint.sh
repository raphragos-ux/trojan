#!/bin/bash
set -e

# Gumawa ng SSL cert (walang bansa/lokasyon, simple lang)
openssl req -x509 -newkey rsa:4096 -keyout /app/key.key -out /app/cert.crt -days 3650 -nodes -subj "/CN=trojan-server"

# Awtomatikong gamitin ang PORT mula sa GCP
sed -i "s/listen 8080;/listen $PORT;/" /etc/nginx/nginx.conf

# Simulan ang Nginx
nginx

# Simulan ang Trojan
exec trojan -c /app/config.json
