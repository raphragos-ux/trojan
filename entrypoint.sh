#!/bin/bash
set -e

openssl req -x509 -newkey rsa:4096 -keyout /app/key.key -out /app/cert.crt -days 3650 -nodes -subj "/CN=trojan-server"

echo "OK" > /usr/share/nginx/html/index.html

nginx

exec trojan -c /app/config.json

