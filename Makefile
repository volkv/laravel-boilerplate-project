exec:
	docker-compose exec -u root php-fpm $$cmd

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-build:
	docker-compose up --build -d

storage-link:
	make exec cmd="php artisan storage:link"

pull:
	git pull
	sudo chown -R www-data:www-data storage/framework/views/
	sudo chmod -R 775  storage/framework/views/

update: docker-stop-all pull perm docker-build composer-update npm-install npm-prod cache
update-prod: pull perm docker-build composer-update-prod npm-install npm-prod cache

docker-stop-all:
	docker stop $$(docker ps -q) || true

key-generate:
	make exec cmd="php artisan key:generate"

bash:
	make exec cmd="bash"

npm-dev:
	make exec cmd="npm run dev"

migrate:
	make exec cmd="php artisan migrate"

migrate-rollback:
	make exec cmd="php artisan migrate:rollback"

composer-update:
	make exec cmd="composer update"

composer-update-prod:
	make exec cmd="composer update --no-dev"

composer-install:
	make exec cmd="composer install"

npm-install:
	make exec cmd="npm install"

npm-update:
	make exec cmd="npm update"

npm-prod:
	make exec cmd="npm run prod"

npm-watch:
	make exec cmd="npm run watch"

perm:
	sudo chown -R www-data:www-data .
	sudo chmod -R 775  .

cache:
	make exec cmd="php artisan volkv:cache"

opcache-clear:
	make exec cmd="php artisan opcache:clear"

composer-install-prod:
	make exec cmd="composer install --no-dev"

composer-dump:
	make exec cmd="composer dump-autoload"

seed:
	make exec cmd="php artisan db:seed"

install:
	make exec cmd="php artisan storage:link"
	make exec cmd="php artisan key:generate"

log-queue:
	docker-compose logs --tail="50" queue-default

log-sql:
	docker-compose logs --tail="50" sql

log-scheduler:
	docker-compose logs --tail="50" scheduler

log-nginx:
	docker-compose logs --tail="50" nginx

backup-db:
	docker-compose exec  -u root  -T sql bash -c  "pg_dump -Fc db > /backups/backup.gz && cp /backups/backup.gz /backups/old/`date +%d-%m-%Y"_"%H_%M_%S`.gz"

restore-db:
	docker-compose exec  -u root  -T sql bash -c  "pg_restore --clean -d db -j 4 /backups/backup.gz"
