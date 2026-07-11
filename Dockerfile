FROM alpine:3.20

WORKDIR /etc/trojan

# I-install ang mga kailangan
RUN apk update && apk upgrade && \
    apk add --no-cache nginx bash curl tzdata openssl && \
    rm -rf /var/cache/apk/*

# 🚀 DIREKTANG BINARY, WALANG EXTRACT — siguradong walang mali
RUN curl -L -o /usr/local/bin/trojan https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64 && \
    chmod +x /usr/local/bin/trojan

# Kopyahin ang mga config
COPY config.json /etc/trojan/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
