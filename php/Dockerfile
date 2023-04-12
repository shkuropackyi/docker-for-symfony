ARG PHP_VERSION
ARG COMPOSER_VERSION

FROM composer:${COMPOSER_VERSION} AS composer_image
FROM php:${PHP_VERSION}-fpm AS app_prod

## User configuration
ARG APPLICATION_USER_ID
ARG APPLICATION_USER_GROUP
RUN echo "app-container:x:$APPLICATION_USER_ID:$APPLICATION_USER_GROUP:container,,,:/:/bin/bash" >> /etc/passwd
RUN echo "app-container:x:$APPLICATION_USER_GROUP:" >> /etc/group

## Update
RUN apt-get update
RUN apt-get update --fix-missing

## Setup configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
ADD php/dev/config/* /usr/local/etc/php/conf.d/

RUN docker-php-source extract \
    && apt-get install -y libxml2-dev libxslt1-dev \
    && apt-get install -y libzip-dev zip unzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo pdo_mysql

## Install Composer
COPY --from=composer_image /usr/bin/composer /usr/local/bin/composer

# Instal wkhtmltopdf
RUN apt-get --allow-releaseinfo-change update
RUN apt-get install -y wget fontconfig libjpeg62-turbo libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base

FROM app_prod AS app_dev

# Install Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Set up Xdebug configuration
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
