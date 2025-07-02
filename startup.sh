#!/bin/bash
cp .env /home/site/wwwroot
cd /home/site/wwwroot
php artisan serve
