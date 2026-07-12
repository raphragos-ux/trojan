FROM alpine:3.19

# ✅ WALA NANG NGINX — mas maliit, mas mabilis, walang error!
RUN apk update --no-cache && apk upgrade --no-cache && \
    apk add --no-cache openssl wget tar bash tzdata xz && \
    rm -rf /var/cache/apk/*

ENV PORT=8080
WORKDIR /app

# ✅ Tamang pagkuha ng Trojan
RUN wget -O trojan.tar.xz https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.xz && \
    tar -Jxf trojan.tar.xz && \
    mv trojan /usr/bin/ && \
    chmod +x /usr/bin/trojan && \
    rm -rf trojan.tar.xz

COPY config.json /app/config.json
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod 755 /app/entrypoint.sh && chmod 644 /app/config.json

EXPOSE 8080

CMD ["/bin/bash", "/app/entrypoint.sh"]
