FROM alpine:3.19

# ✅ Gumamit ng unzip sa halip na xz
RUN apk update --no-cache && apk upgrade --no-cache && \
    apk add --no-cache \
        nginx \
        openssl \
        wget \
        tar \
        bash \
        tzdata \
        unzip && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# ✅ I-download ang ZIP VERSION ng Trojan (walang xz error!)
RUN wget -O trojan.zip https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.zip && \
    unzip trojan.zip && \
    cp trojan-1.16.0-linux-amd64/trojan /usr/bin/ && \
    chmod +x /usr/bin/trojan && \
    rm -rf trojan.zip trojan-1.16.0-linux-amd64

COPY config.json /app/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod 755 /app/entrypoint.sh && chmod 644 /app/config.json

EXPOSE 80 443

CMD ["/bin/bash", "/app/entrypoint.sh"]
