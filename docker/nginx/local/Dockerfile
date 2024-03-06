FROM nginx:1.25.4-alpine

RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /etc/nginx/certificates

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certificates/key.pem -out /etc/nginx/certificates/cert.pem -subj "/C=AT/ST=Moscow/L=Moscow/O=Security/OU=Development/CN=localhost"

ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf

ADD 'local/ssl/cert.pem' /etc/nginx/certificates
ADD 'local/ssl/key.pem' /etc/nginx/certificates

WORKDIR /var/www
