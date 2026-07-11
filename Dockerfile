FROM alpine:3.20

WORKDIR /etc/trojan

RUN apk update && apk upgrade && \
    apk add --no-cache nginx bash tzdata openssl curl && \
    rm -rf /var/cache/apk/*

# Download Trojan (gamitin ito kung Trojan; palitan kung VLESS)
RUN curl -L -o /usr/local/bin/trojan https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64 && \
    chmod +x /usr/local/bin/trojan

COPY config.json /etc/trojan/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# ✅ BUKAS ANG PORT NA GUSTO NG GCP: 8080
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
