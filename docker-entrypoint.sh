#!/bin/sh
set -e

# Run composer install if vendor directory is missing
if [ ! -d "vendor" ]; then
    composer install --no-interaction --optimize-autoloader
fi

# Run migrations if DB is available (handled by Laravel during migrations)
# Wait for DB to be ready
echo "Waiting for database..."
# Simple sleep for now, can be improved with wait-for-it.sh
sleep 10

# Fix permissions
echo "Fixing permissions..."
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Ensure .env is writable for key generation
if [ -f ".env" ]; then
    chown www-data:www-data .env
    chmod 664 .env
fi

# Generate app key if not set
php artisan key:generate --no-interaction --force

# Force clear all caches manually to avoid boot errors
rm -f bootstrap/cache/config.php
rm -f bootstrap/cache/services.php
rm -f bootstrap/cache/packages.php

php artisan config:clear
php artisan cache:clear

php artisan migrate --force
php artisan passport:keys --force

# Start PHP-FPM
exec "$@"
