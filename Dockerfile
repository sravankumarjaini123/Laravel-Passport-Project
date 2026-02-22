# Stage 1: Build Assets
FROM node:20-alpine AS build-stage
LABEL maintainer="Sravan Kumar Jaini"
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: PHP Application
FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    oniguruma-dev \
    libzip-dev \
    sqlite-dev \
    icu-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql pdo_sqlite mbstring exif pcntl bcmath gd zip intl

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY . .

# Copy built assets from build-stage
COPY --from=build-stage /app/public/build ./public/build

# Install composer dependencies
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Copy entrypoint script
 COPY docker-entrypoint.sh /usr/local/bin/
 RUN chmod +x /usr/local/bin/docker-entrypoint.sh
 
 # Expose port 9000 and start php-fpm server
 EXPOSE 9000
 ENTRYPOINT ["docker-entrypoint.sh"]
 CMD ["php-fpm"]
