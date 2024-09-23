## Локальный запуск (Linux / macOS):

##### Local SSL (https://github.com/FiloSottile/mkcert)

```shell
mkcert -key-file key.pem -cert-file cert.pem localhost && mv key.pem docker/nginx/local/ssl && mv cert.pem docker/nginx/local/ssl
```

##### /etc/hosts

`127.0.0.1  localhost`

##### .env

`cp .env.example .env`

> APP_NAME=laravel-app

* git (`apt install git`)
* make (`apt install make`)
* docker (`wget -O- get.docker.com | bash`)

### Сборка Local

* `make update-local`

### Сборка Prod

* `make update-prod`

https://localhost:8080/
