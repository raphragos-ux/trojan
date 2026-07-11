FROM alpine:3.20

WORKDIR /etc/trojan

# I-install ang mga kailangang pakete
RUN apk update && apk upgrade && \
    apk add --no-cache nginx bash curl tzdata openssl && \
    rm -rf /var/cache/apk/*

# ✅ TAMANG PAG-EXTRACT: alam natin ang loob ng file
RUN set -e; \
    curl -L -o /tmp/trojan.tar.gz https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.gz; \
    tar -zxf /tmp/trojan.tar.gz -C /tmp; \
    mv /tmp/trojan-1.16.0-linux-amd64/trojan /usr/local/bin/; \
    chmod +x /usr/local/bin/trojan; \
    rm -rf /tmp/*

# Kopyahin ang mga config
COPY config.json /etc/trojan/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
