ARG PHP_VERSION=7.2

FROM php:${PHP_VERSION}-fpm

RUN     apt-get update\
        && apt-get install libzip-dev zip unzip zlib1g-dev libicu-dev g++ -y\
        && docker-php-ext-configure intl\
        && docker-php-ext-install pdo_mysql zip intl\
        && yes | pecl install xdebug\
        && docker-php-ext-enable xdebug\
        && echo "\n\
            xdebug.mode=debug \n\
            xdebug.client_port=9050 \n\
            xdebug.discover_client_host=1 \n\
            xdebug.client_host=server \n\
            xdebug.start_with_request=yes \n\
        " >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;
