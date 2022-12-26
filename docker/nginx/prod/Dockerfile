FROM nginx:1.23.3-alpine

RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /etc/nginx/certificates

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certificates/key.pem -out /etc/nginx/certificates/cert.pem -subj "/C=AT/ST=Vienna/L=Vienna/O=Security/OU=Development/CN=example.com"

ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf
ADD prod/cloudflare.conf /etc/nginx/conf.d/cloudflare.conf

WORKDIR /var/www
