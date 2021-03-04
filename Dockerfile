FROM nginx:1.19-alpine

RUN apk update
RUN apk add --no-cache --upgrade tzdata lego openssl

COPY root/defaults/nginxconfig.io/nginx.conf /etc/nginx/nginx.conf

# add local files
COPY root/ /
