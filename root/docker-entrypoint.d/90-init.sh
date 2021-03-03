#!/bin/sh

if [ ! -d "/config" ]; then
  echo "config directory not found!"
  exit 1
fi

if [ ! -d "/lego" ]; then
  echo "lego directory not found!"
  exit 1
fi

mkdir -p "/config/nginx/sites-enabled"

if [ ! -f "/config/nginx/dhparams.pem" ]; then
  echo "Diffie-Hellman file does not exist. Will create a new one."
  openssl dhparam -out "/config/nginx/dhparams.pem" 4096
else
  echo "Diffie-Hellman file already exists. Skipping creation."
fi

if [ ! -d "/lego/certificates" ]; then
  echo "SSL certificates not found. Will attempt to create new ones."
  /etc/periodic/daily/lego-cert
else
  echo "SSL certificates already present. Skipping creation."
fi

if [ ! -f "/config/nginx/proxy.conf" ]; then
  echo "Copying proxy.conf"
  cp "/defaults/nginxconfig.io/proxy.conf" "/config/nginx/proxy.conf"
fi
if [ ! -f "/config/nginx/security.conf" ]; then
  echo "Copying security.conf"
  cp "/defaults/nginxconfig.io/security.conf" "/config/nginx/security.conf"
fi
if [ ! -f "/config/nginx/general.conf" ]; then
  echo "Copying general.conf"
  cp "/defaults/nginxconfig.io/general.conf" "/config/nginx/general.conf"
fi
