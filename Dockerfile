FROM alpine:3.19

# ✅ TAMANG PAKETE: xz lang ang pangalan sa Alpine 3.19
RUN apk update --no-cache && apk upgrade --no-cache && \
    apk add --no-cache \
        nginx \
        openssl \
        wget \
        tar \
        bash \
        tzdata \
        xz && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# ✅ DIREKTANG BINARY DOWNLOAD — WALANG EXTRACT, WALANG ERROR!
RUN wget -O /usr/bin/trojan https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64/trojan && \
    chmod +x /usr/bin/trojan

COPY config.json /app/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod 755 /app/entrypoint.sh && chmod 644 /app/config.json

EXPOSE 80 443

CMD ["/bin/bash", "/app/entrypoint.sh"]
