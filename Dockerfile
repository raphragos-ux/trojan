# Gumamit ng Alpine 3.20 bilang base
FROM alpine:3.20

WORKDIR /etc/trojan

# I-install muna ang mga kailangang tools
RUN apk update && apk upgrade && \
    apk add --no-cache nginx bash curl tzdata openssl wget && \
    rm -rf /var/cache/apk/*

# 📥 I-download at i-install ang Trojan mula sa official source
RUN set -e; \
    wget -O /tmp/trojan.tar.gz https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.gz; \
    tar -zxf /tmp/trojan.tar.gz -C /usr/local/bin/ trojan; \
    chmod +x /usr/local/bin/trojan; \
    rm -f /tmp/trojan.tar.gz

# Kopyahin ang mga config files
COPY config.json /etc/trojan/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
