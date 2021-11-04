## Локальный запуск (Linux / macOS):

##### Local SSL (https://github.com/FiloSottile/mkcert)
`mkcert -key-file key.pem -cert-file cert.pem localhost && mv -t docker/nginx/local/ssl/ key.pem cert.pem`
##### /etc/hosts
`127.0.0.1  localhost`
##### .env
`cp .env.example .env`

> APP_NAME=laravel-app
* git (`apt install git`)
* make (`apt install make`)
* docker / docker-compose (`apt install docker-compose`)

### Сборка Local

* `make update`
* 
### Сборка Prod

* `make update-prod`

### TODO

- [ ] Общий docker-compose
