Nginx Lego Docker Image
=======================

## What's this ##
This is a simple [Nginx Docker](https://hub.docker.com/_/nginx/) image with [Lego](https://github.com/go-acme/lego) to automate [Let's Encrypt](https://letsencrypt.org/) certificate generation and renewal. Currently only supported for [DuckDNS](https://www.duckdns.org/) (for both main domain and subdomains -wildcard) and only for the dns-01 challenge.

The Nginx configuration is based on the [NGINXConfig from Digital Ocean](https://www.digitalocean.com/community/tools/nginx) and the [SSL Configuration Generator from Mozilla](https://ssl-config.mozilla.org/).

SSL certificates are checked every night for renewal (without contacting Let's Encrypt), and renewals are done when the certificates have less than 30 days to expire.

## How to use ##
Just add your subdomain configuration files in `/config/nginx/sites-enabled`, with a name ending in `subdomain.conf`. Here's an example:
```
server {
    include             /etc/nginx/conf.d/subdomains-common;
    server_name         subdomain.*;

    # security
    include             /config/nginx/security.conf;

    # reverse proxy
    location / {
        proxy_pass http://$docker_host:3000;
        include    /config/nginx/proxy.conf;
    }

    # additional config
    include /config/nginx/general.conf;
}
```

## Running ##
This image is intended to be run with docker-compose. Here's an example with the expected environment variables:
```
version: "3.5"
services:
  nginx:
    container_name: nginx_proxy
    image: jbequinn/nginx-lego:1.19.8.1
    restart: unless-stopped
    ports:
      - "8443:443"
    volumes:
      - lego:/lego
      - config:/config
    environment:
      - PROXY_HOST=<the ip address of the server which runs the services>
      - DOMAIN=<your duckdns domain>
      - DUCKDNS_TOKEN=<your duckdns token>
      - EMAIL=<email used for the Let's Encrypt account>
#     staging address for testing
#      - SERVER=https://acme-staging-v02.api.letsencrypt.org/directory
      - SERVER=https://acme-v02.api.letsencrypt.org/directory
      - DUCKDNS_PROPAGATION_TIMEOUT=90
      - DUCKDNS_POLLING_INTERVAL=5

volumes:
  lego:
  config:
```

## Building ##
If you prefer not to use the image from [Docker Hub](https://hub.docker.com/repository/docker/jbequinn/nginx-lego), you can build your own image using the command:
```
docker build --no-cache --pull -t my-nginx:1.19-alpine-1 .
```
