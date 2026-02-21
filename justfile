# Runs setup and starts development environment
default: setup start migrate

# Creates .env file and "shared_composer" docker volume if they do not exist
setup:
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

# Starts docker containers
start:
    #!/bin/bash
    docker compose up -d

    docker compose exec backend composer install

    if [ -z "${APP_KEY}" ]; then
        echo "APP_KEY is not set. Generating a new key..."
        docker compose exec backend php artisan key:generate
    fi

# Stops docker containers
stop:
    docker compose stop

# Removes docker containers
down *ARGS:
    docker compose down {{ARGS}}

# Runs pending database migrations
[group('database')]
migrate:
    docker compose exec backend php artisan migrate

# Resets database, runs all migrations and seeds the database
[group('database')]
migrate-fresh:
    docker compose exec backend php artisan migrate:fresh --seed

# Seeds the database
[group('database')]
seed:
    docker compose exec backend php artisan db:seed

# Runs linter
[group('frontend')]
lint:
    docker compose exec frontend pnpm lint
