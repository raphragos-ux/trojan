# Mas matibay na base image
FROM alpine:3.20

WORKDIR /etc/trojan

# I-install ang lahat ng kailangan
RUN apk update && apk upgrade && \
    apk add --no-cache nginx bash curl tzdata openssl && \
    rm -rf /var/cache/apk/*

# ✅ GAMITIN ANG CURAL SA PAG-DOWNLOAD (mas maaasahan kaysa wget)
RUN set -e; \
    curl -L -o /tmp/trojan.tar.gz https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.gz; \
    tar -zxf /tmp/trojan.tar.gz -C /usr/local/bin/ trojan; \
    chmod +x /usr/local/bin/trojan; \
    rm -f /tmp/trojan.tar.gz

# Kopyahin ang mga file
COPY config.json /etc/trojan/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]

