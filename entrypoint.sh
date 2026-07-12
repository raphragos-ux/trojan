#!/bin/bash
set -e

openssl req -x509 -newkey rsa:4096 -keyout /app/key.key -out /app/cert.crt -days 3650 -nodes -subj "/C=PH/ST=Visayas/L=Iloilo/O=FreeData/CN=virgozki.com"

nginx

echo "✅ Nginx sa 8080 | Trojan sa 8443 | PATH: /trojan-ws"
exec trojan -c /app/config.json
