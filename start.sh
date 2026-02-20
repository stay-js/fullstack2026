#!/bin/bash

if [ -f ".env" ]; then
    echo ".env file already exists. Skipping..."
else
    echo ".env file does not exist. Copying from .env.example..."
    cp .env.example .env
fi

if docker volume inspect shared_composer >/dev/null 2>&1; then
    echo "Docker volume 'shared_composer' already exists. Skipping..."
else
    echo "Docker volume 'shared_composer' does not exist. Creating..."
    docker volume create shared_composer
fi

docker compose up -d

docker compose exec backend composer install
docker compose exec backend php artisan migrate

if [ -z "${APP_KEY}" ]; then
    echo "APP_KEY is not set. Generating a new key..."
    docker compose exec backend php artisan key:generate
fi
