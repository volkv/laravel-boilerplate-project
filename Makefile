exec:
	docker-compose exec php-fpm $$cmd

exec-root:
	docker-compose exec -u root php-fpm $$cmd

execTTY:
	docker-compose exec -T  php-fpm $$cmd

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
	make exec-root cmd="npm install"

npm-update:
	make exec-root cmd="npm update"

npm-prod:
	make exec-root cmd="npm run build"

npm-watch:
	make exec-root cmd="npm run watch"

perm:
	sudo chown -R www-data:www-data .
	sudo chmod -R 775  .

cache:
	make exec cmd="php artisan volkv:cache"

cache-noide:
	make execTTY cmd="php artisan volkv:cache --noide"

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
	docker-compose exec  -u root  -T sql bash -c  "pg_dump -Fc postgres > /backups/backup.gz && cp /backups/backup.gz /backups/old/`date +%d-%m-%Y"_"%H_%M_%S`.gz"

restore-db:
	docker-compose exec  -u root  -T sql bash -c  "dropdb --if-exists postgres && createdb postgres && pg_restore --create -d postgres -j 4 /backups/backup.gz"

include .env

push-db:
	scp -i ~/.ssh/id_rsa docker/volume/postgres/backup.gz root@${SERVER_IP}:${GITHUB_REPOSITORY}/docker/volume/postgres/backup.gz

pull-db:
	scp root@${SERVER_IP}:${GITHUB_REPOSITORY}/docker/volume/postgres/backup.gz docker/volume/postgres/backup.gz

pull-restore-db: pull-db restore-db

deploy:
	ssh root@${SERVER_IP} 'cd ${GITHUB_REPOSITORY} && git reset --hard && make after-pull-perm && git pull https://${GITHUB_CREDENTIALS}@github.com/volkv/${GITHUB_REPOSITORY}.git && make after-pull-perm && make update-prod'

_test-pre:
	make docker-build && \
	make npm-prod && \
	make cache-noide

after-test:
	export PHP_OPCACHE=0 && \
	make docker-build
	make cache-noide

_test-all:
	make exec cmd="/var/www/vendor/phpunit/phpunit/phpunit --configuration /var/www/phpunit.xml /var/www/tests"

_test-feature:
	make exec cmd="/var/www/vendor/phpunit/phpunit/phpunit --configuration /var/www/phpunit.xml /var/www/tests/Feature"

test: _test-pre _test-all after-test
