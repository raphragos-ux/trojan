# Gumamit ng magaan na base image
FROM alpine:3.20

# Mag-set ng working directory
WORKDIR /etc/trojan

# I-install ang mga kailangang pakete
RUN apk update && apk upgrade && \
    apk add --no-cache nginx trojan bash curl tzdata && \
    rm -rf /var/cache/apk/*

# Kopyahin ang mga file papasok sa container
COPY config.json /etc/trojan/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

# Bigyan ng pahintulot na tumakbo ang script
RUN chmod +x /entrypoint.sh

# Buksan ang mga port na gagamitin
EXPOSE 80 443

# I-set ang entrypoint
ENTRYPOINT ["/entrypoint.sh"]
