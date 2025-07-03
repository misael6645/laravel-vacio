#!/bin/bash

cd /home/site/wwwroot

# Usar el servidor PHP con el document root en la carpeta 'public'
php -S 0.0.0.0:8080 -t public
