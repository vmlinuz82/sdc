#!/bin/sh
# Substitute environment variables in nginx.conf.template and create nginx.conf
envsubst '${PROJECT_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start Nginx in the foreground
nginx -g 'daemon off;'