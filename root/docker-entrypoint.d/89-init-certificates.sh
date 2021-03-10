#!/bin/sh

if [ ! -d "/lego" ]; then
  echo "lego directory not found!"
  exit 1
fi

echo "- Checking SSL certificate and Diffie-Hellman parameters."

if [ ! -d "/lego/certificates" ]; then
  /etc/periodic/daily/lego-cert
else
  echo "  * SSL certificates already present. Skipping creation."
fi

if [ ! -f "/config/nginx/dhparam.pem" ]; then
  echo "  * Diffie-Hellman file does not exist. Will create a new one."
  openssl dhparam -out "/config/nginx/dhparam.pem" 4096
else
  echo "  * Diffie-Hellman file already exists. Skipping creation."
fi

