#!/bin/bash
set -e
if [ ! -f /etc/trojan/cert.crt ] || [ ! -f /etc/trojan/key.key ]; then
    openssl req -x509 -newkey rsa:4096 -keyout /etc/trojan/key.key -out /etc/trojan/cert.crt -days 3650 -nodes -subj "/C=PH/ST=Visayas/L=Iloilo/O=Trojan/CN=trojan.local"
fi
nginx -g "daemon off;" &
exec trojan -c /etc/trojan/config.json
