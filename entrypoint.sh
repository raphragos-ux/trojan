#!/bin/bash
set -e

# Gumawa ng self-signed SSL certificate kung wala
if [ ! -f /etc/trojan/cert.crt ] || [ ! -f /etc/trojan/key.key ]; then
    echo "Generating self-signed SSL certificate..."
    openssl req -x509 -newkey rsa:4096 -keyout /etc/trojan/key.key -out /etc/trojan/cert.crt -days 3650 -nodes -subj "/C=PH/ST=Manila/L=Manila/O=Trojan/OU=IT/CN=trojan.local"
fi

# Simulan ang Nginx sa background
echo "Starting Nginx..."
nginx -g "daemon off;" &

# Simulan ang Trojan Server
echo "Starting Trojan Server..."
exec trojan -c /etc/trojan/config.json
