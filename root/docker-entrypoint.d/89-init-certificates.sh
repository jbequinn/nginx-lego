#!/bin/sh

if [ ! -d "/lego" ]; then
  echo "lego directory not found!"
  exit 1
fi

echo "- Checking certificates"
if [ ! -f "/config/nginx/dhparams.pem" ]; then
  echo "  * Diffie-Hellman file does not exist. Will create a new one."
  openssl dhparam -out "/config/nginx/dhparams.pem" 4096
else
  echo "  * Diffie-Hellman file already exists. Skipping creation."
fi

if [ ! -d "/lego/certificates" ]; then
  echo "  * SSL certificates not found. Will attempt to create new ones."
  /etc/periodic/daily/lego-cert
else
  echo "  * SSL certificates already present. Skipping creation."
fi
