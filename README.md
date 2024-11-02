## Локальный запуск (Linux / macOS):

##### Local SSL (https://github.com/FiloSottile/mkcert)

```shell
mkcert -key-file key.pem -cert-file cert.pem localhost && mv key.pem docker/nginx/local/ssl && mv cert.pem docker/nginx/local/ssl
```

##### /etc/hosts

`127.0.0.1  localhost`

##### .env

```shell
cp .env.example .env
```
> APP_NAME=your-app-name
##### git & make (`apt install git`)
```shell
apt install git make
```
##### docker
```shell
wget -O- get.docker.com | bash
```
### Сборка Local
```shell
make update-local
```
### Сборка Prod

```shell
make update-prod
```
### Setup (key generate & storage link)
```shell
make setup
```

```shell
make npm-watch
make npm-watch
```
https://localhost:8080/

