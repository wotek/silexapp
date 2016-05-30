# Silex Dockerfile
#
# Version 0.0.1
FROM php:5.5-fpm-alpine
MAINTAINER Wojtek Zalewski <wojtek@neverbland.com>

LABEL Description="This image is used to start the foobar executable" Vendor="ACME Products" Version="1.0"

# Port we are going to expose
EXPOSE 8080

# Lets updates packages lists
RUN apk update --update-cache

# Lets install our system dependencies
RUN apk add \
    curl \
    git \
    openssh

# Lets copy our php config
COPY docker/php/php.ini /usr/local/etc/php/

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Setting up default working directory
WORKDIR /usr/src/slate

# Lets add composer file in order to install deps
ADD app/composer.json /usr/src/slate

# Install dependencies
RUN composer install --prefer-dist --working-dir=/usr/src/slate

# Lets mount volumes
VOLUME /usr/src/slate/app


