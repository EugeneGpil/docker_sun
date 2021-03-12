ARG PHP_VERSION=7.2

FROM laradock/workspace:2.5-${PHP_VERSION}

ARG COMPOSER_VERSION=2.0.11
ARG PHP_VERSION=7.2

RUN     apt-get update\
        && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer\
        && composer self-update ${COMPOSER_VERSION}\
        && pecl install mongodb\
        && echo "extension=mongodb.so" >> /etc/php/${PHP_VERSION}/mods-available/mongodb.ini\
        && ln -s /etc/php/${PHP_VERSION}/mods-available/mongodb.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-mongodb.ini

RUN     pecl install redis\
        && echo "extension=redis.so \n" >> /etc/php/${PHP_VERSION}/cli/php.ini

RUN     apt-get install apt-utils libzip-dev zip unzip php${PHP_VERSION}-zip nasm -y
