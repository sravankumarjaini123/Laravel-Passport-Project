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

php artisan migrate --force
php artisan passport:keys --force

# Start PHP-FPM
exec "$@"
