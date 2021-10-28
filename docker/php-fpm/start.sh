#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE}

if [ "$role" = "app" ]; then

  exec php-fpm

elif [ "$role" = "queue-default" ]; then
  sleep 10
  while [ true ]; do
    echo "Running the queue..."
    php /var/www/artisan queue:work --queue=default --verbose --tries=1 --timeout=600

  done

elif [ "$role" = "scheduler" ]; then
  sleep 10
  while [ true ]; do
    php /var/www/artisan schedule:run --verbose
    sleep 60
  done

fi
