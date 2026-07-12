FROM alpine:3.19

RUN apk update --no-cache && apk upgrade --no-cache && \
    apk add --no-cache openssl wget gzip bash tzdata && \
    rm -rf /var/cache/apk/*

ENV PORT=8080
WORKDIR /app

# ✅ TAMANG LINK AT TAMANG PAGPAPALIT NG PANGALAN
RUN wget -O gost.gz https://github.com/ginuerzh/gost/releases/download/v2.11.2/gost-linux-amd64.gz && \
    gzip -d gost.gz && \
    mv gost-linux-amd64 /usr/bin/gost && \
    chmod +x /usr/bin/gost

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod 755 /app/entrypoint.sh

EXPOSE 8080

CMD ["/bin/bash", "/app/entrypoint.sh"]
