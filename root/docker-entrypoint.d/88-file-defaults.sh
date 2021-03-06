#!/bin/sh

if [ ! -d "/config" ]; then
  echo "config directory not found!"
  exit 1
fi

mkdir -p "/config/nginx/sites-enabled"

echo "- Checking configuration files"

if [ ! -f "/config/nginx/proxy.conf" ]; then
  echo "  * Copying proxy.conf"
  cp "/defaults/nginxconfig.io/proxy.conf" "/config/nginx/proxy.conf"
fi
if [ ! -f "/config/nginx/security.conf" ]; then
  echo "  * Copying security.conf"
  cp "/defaults/nginxconfig.io/security.conf" "/config/nginx/security.conf"
fi
if [ ! -f "/config/nginx/general.conf" ]; then
  echo "  * Copying general.conf"
  cp "/defaults/nginxconfig.io/general.conf" "/config/nginx/general.conf"
fi
