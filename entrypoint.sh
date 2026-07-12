#!/bin/bash
set -e

openssl req -x509 -newkey rsa:4096 -keyout /app/key.key -out /app/cert.crt -days 3650 -nodes -subj "/CN=trojan-server"

# ✅ HEALTH CHECK SERVER SA PORT 8080 — gumagamit ng netcat na na-install na
(while true; do echo -e "HTTP/1.1 200 OK\n\nOK" | nc -l -p 8080; done) &

# ✅ SIMULAN ANG TROJAN
exec trojan -c /app/config.json
