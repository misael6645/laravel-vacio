FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    zip unzip curl git libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

RUN a2enmod rewrite

# Instala Composer globalmente
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Copia composer files primero para cache
COPY composer.json composer.lock /var/www/html/

WORKDIR /var/www/html

RUN composer install --no-dev --optimize-autoloader

# Ahora copia el resto del código (excepto vendor y node_modules)
COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

COPY ./apache.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
