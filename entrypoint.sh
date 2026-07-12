#!/bin/bash
set -e

# Gumawa ng SSL cert
openssl req -x509 -newkey rsa:4096 -keyout /app/key.key -out /app/cert.crt -days 3650 -nodes -subj "/C=PH/ST=Visayas/L=Iloilo/O=FreeData/CN=virgozki.com"

# I-check kung may Trojan
if ! command -v trojan &> /dev/null; then
    echo "❌ Trojan binary hindi nakita!"
    exit 1
fi

# Simulan Nginx sa background
nginx

# Simulan Trojan (ipakita ang log)
echo "✅ Trojan Server nagsimula na sa port 443"
exec trojan -c /app/config.json
