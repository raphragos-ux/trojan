#!/bin/bash
set -e

# Gumawa ng SSL cert
openssl req -x509 -newkey rsa:4096 -keyout /app/key.key -out /app/cert.crt -days 3650 -nodes -subj "/CN=trojan-server"

# ✅ Ipakita na handa na
echo "✅ Trojan + WebSocket nakikinig sa PORT $PORT"

# Simulan ang Trojan — ITO NA LANG ANG IISIMULA!
exec trojan -c /app/config.json
