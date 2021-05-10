ARG PHP_VERSION=7.2

FROM laradock/workspace:2.5-${PHP_VERSION}

ARG COMPOSER_VERSION=2.0.11
ARG PHP_VERSION=7.2
ARG REDIS_VERSION=6.0.10
RUN     apt-get update\
        && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer\
        && composer self-update ${COMPOSER_VERSION}\
        && pecl install mongodb\
        && echo "extension=mongodb.so" >> /etc/php/${PHP_VERSION}/mods-available/mongodb.ini\
        && ln -s /etc/php/${PHP_VERSION}/mods-available/mongodb.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-mongodb.ini\
        && apt-get install apt-utils libzip-dev zip unzip php${PHP_VERSION}-zip nasm -y\
        && curl -O https://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz\
        && tar xzvf redis-${REDIS_VERSION}.tar.gz\
        && cd redis-${REDIS_VERSION}\
        && make\
        && make install
