FROM alpine:3.19

# I-install ang mga kailangan
RUN apk update --no-cache && apk upgrade --no-cache && \
    apk add --no-cache nginx openssl wget tar bash tzdata && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# ✅ Siguradong tama ang pag-download at paglalagay ng Trojan
RUN wget -O trojan.tar.xz https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.xz && \
    tar -xf trojan.tar.xz && \
    cp trojan-1.16.0-linux-amd64/trojan /usr/bin/ && \
    chmod +x /usr/bin/trojan && \
    rm -rf trojan.tar.xz trojan-1.16.0-linux-amd64

# Kopyahin ang config files
COPY config.json /app/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /app/entrypoint.sh

# ✅ Siguradong may tamang pahintulot
RUN chmod 755 /app/entrypoint.sh && chmod 644 /app/config.json

EXPOSE 80 443

CMD ["/bin/bash", "/app/entrypoint.sh"]
