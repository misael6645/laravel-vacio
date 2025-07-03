#!/bin/bash

cd /site/wwwroot

# Usar el servidor PHP con el document root en la carpeta 'public'
php -S 0.0.0.0:9000 -t public
