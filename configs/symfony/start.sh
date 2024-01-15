#!/bin/sh

SYMFONY_VERSION='7.0.*'

if [ -z "$(ls -A "/var/www")" ]; then
  mkdir -p /var/www
fi

# Initialize empty Symfony app in /var/www/app
if [ -z "$(ls -A "/var/www/app")" ]; then
  echo "The directory /var/www/app not exists. Initialization new Symfony application in /var/www/app."
  cd /var/www
  symfony new app --version="$SYMFONY_VERSION" --no-git
  touch /var/www/app/.env
  chown -R app:app /var/www/app
else
    echo "The directory /var/www/app is not empty. Initialization skipped."
fi

# Set the PS1 environment variable to show correct terminal prompt when you logged in the container
echo 'PS1="\\u@tinkers-bench.app:\\w\\$ "' >> /home/app/.bashrc \
&& echo 'PS1="\\u@tinkers-bench.app:\\w\\$ "' >> /root/.bashrc

# Configure php xdebug
CLIENT_HOST=$(/sbin/ip route|awk '/default/ { print $3 }')
echo "zend_extension=xdebug.so" > /etc/php/8.2/cli/conf.d/20-xdebug.ini \
&& echo "xdebug.mode=develop,coverage,debug,profile" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini \
&& echo "xdebug.start_with_request=yes" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini \
&& echo "xdebug.client_host=$CLIENT_HOST" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini \
&& echo "xdebug.client_port=9003" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini \
&& echo "zend_extension=xdebug.so" > /etc/php/8.2/fpm/conf.d/20-xdebug.ini \
&& echo "xdebug.mode=develop,coverage,debug,profile" >> /etc/php/8.2/fpm/conf.d/20-xdebug.ini \
&& echo "xdebug.start_with_request=yes" >> /etc/php/8.2/fpm/conf.d/20-xdebug.ini \
&& echo "xdebug.client_host=$CLIENT_HOST" >> /etc/php/8.2/fpm/conf.d/20-xdebug.ini \
&& echo "xdebug.client_port=9003" >> /etc/php/8.2/cli/conf.d/20-xdebug.ini

# Replace 'listen' directive in www.conf to tell php to listen on port 9000 not a Unix socket
sed -i 's/listen = .*/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf \
&& sed -i 's/user = www-data/user = app/' /etc/php/8.2/fpm/pool.d/www.conf \
&& sed -i 's/group = www-data/group = app/' /etc/php/8.2/fpm/pool.d/www.conf

# Start supervisor
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf