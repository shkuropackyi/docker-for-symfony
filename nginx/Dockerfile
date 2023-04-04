ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}

## Update
RUN apt-get update
RUN apt-get update --fix-missing

RUN touch /var/log/nginx/access.log && chmod 777 /var/log/nginx/access.log \
    && touch /var/log/nginx/error.log && chmod 777 /var/log/nginx/error.log
