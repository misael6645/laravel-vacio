cd /home/site/wwwroot

# --- Limpieza de cachés ---
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# --- Recrear cachés ---
php artisan config:cache
php artisan route:cache
php artisan view:cache

# --- Quitar mantenimiento (por si quedó activado) ---
php artisan up

# --- Iniciar worker en segundo plano (si usas colas) ---
nohup php artisan queue:work > /dev/null 2>&1 &

# --- Iniciar servidor PHP ---
php -S 0.0.0.0:8080 -t public
