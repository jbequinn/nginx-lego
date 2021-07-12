FROM nginx:1.21.1-alpine

RUN apk update
RUN apk add --no-cache --upgrade tzdata openssl
RUN apk add --no-cache --upgrade --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main lego

COPY root/defaults/nginxconfig.io/nginx.conf /etc/nginx/nginx.conf

# add local files
COPY root/ /
