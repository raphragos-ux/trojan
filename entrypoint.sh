#!/bin/bash
set -e

# ✅ Gumawa ng SSL cert
openssl req -x509 -newkey rsa:4096 -keyout key.key -out cert.crt -days 3650 -nodes -subj "/CN=trojan-server"

# ✅ SIMULAN ANG LAHAT SA ISANG UTOS!
# Trojan + WebSocket + HTTP Health Check sa port 8080
exec gost -L "trojan://virgozki123@:$PORT?path=/trojan-ws&cert=/app/cert.crt&key=/app/key.key"
