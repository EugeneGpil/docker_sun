ARG PHP_VERSION=7.2

FROM php:${PHP_VERSION}-fpm

ARG IMAGICK_VERSION=3.4.3
RUN     apt-get update\
        && mkdir /usr/share/man/man1/\
        && apt-get install libzip-dev zip unzip zlib1g-dev libicu-dev libreoffice libmagickwand-dev -y\
        && docker-php-ext-configure intl\
        && docker-php-ext-install pdo_mysql zip intl\
        && pecl install -f imagick-${IMAGICK_VERSION}\
        && yes | pecl install xdebug\
        && docker-php-ext-enable xdebug imagick\
        && echo "\n\
            xdebug.mode=debug \n\
            xdebug.client_port=9050 \n\
            xdebug.discover_client_host=1 \n\
            xdebug.client_host=server \n\
            xdebug.start_with_request=yes \n\
        " >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini\
        && mkdir /var/www/.cache\
        && mkdir /var/www/.cache/dconf\
        && chmod -R 777 /var/www

COPY    gsuite-service-account.json /gsuite-service-account.json
COPY    fonts/* /usr/share/fonts/
