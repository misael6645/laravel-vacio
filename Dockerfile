FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    zip unzip curl git libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

RUN a2enmod rewrite

# Instala Composer (copiando desde la imagen oficial)
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Copia composer.json y composer.lock primero para aprovechar la cache
COPY composer.json composer.lock /var/www/html/

WORKDIR /var/www/html

# Instala dependencias de Composer (esto generará /vendor)
RUN composer install --no-dev --optimize-autoloader -vvv

# Copia el resto de tu código (excepto vendor y node_modules)
COPY . /var/www/html

# Permisos para Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Configuración de Apache personalizada
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
