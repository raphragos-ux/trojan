FROM alpine:3.20

WORKDIR /etc/trojan

# 🚀 I-install ang Trojan + mga kailangan mula sa testing repo
RUN apk update && apk upgrade && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.20/testing nginx trojan bash curl tzdata openssl && \
    rm -rf /var/cache/apk/*

# Kopyahin ang mga config
COPY config.json /etc/trojan/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
