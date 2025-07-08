FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    zip unzip curl git libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Habilita mod_rewrite
RUN a2enmod rewrite

# Copia el código Laravel
COPY . /var/www/html

# Establece permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Copia configuración personalizada para Apache
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
