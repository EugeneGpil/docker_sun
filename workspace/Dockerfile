ARG PHP_VERSION=7.2

FROM laradock/workspace:2.5-${PHP_VERSION}

ARG COMPOSER_VERSION=2.0.11
ARG PHP_VERSION=7.2
ARG REDIS_VERSION=6.0.10
ARG IMAGICK_VERSION=3.4.3
RUN     apt-get update\
        && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer\
        && composer self-update ${COMPOSER_VERSION}\
        && pecl install mongodb\
        && echo "extension=mongodb.so" >> /etc/php/${PHP_VERSION}/mods-available/mongodb.ini\
        && ln -s /etc/php/${PHP_VERSION}/mods-available/mongodb.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-mongodb.ini\
        && apt-get install apt-utils libzip-dev zip unzip php${PHP_VERSION}-zip nasm libmagickwand-dev -y\
        && curl -O https://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz\
        && tar xzvf redis-${REDIS_VERSION}.tar.gz\
        && cd redis-${REDIS_VERSION}\
        && make\
        && make install\
        && yes | pecl install xdebug\
        && echo "\n\
            zend_extension=xdebug \n\
            xdebug.mode=debug \n\
            xdebug.client_port=9050 \n\
            xdebug.discover_client_host=1 \n\
            xdebug.client_host=dockerhost \n\
            xdebug.start_with_request=yes \n\
        " >> /etc/php/${PHP_VERSION}/cli/php.ini\
        && pecl install -f imagick-${IMAGICK_VERSION}\
        && echo "extension=imagick.so" >> /etc/php/${PHP_VERSION}/cli/php.ini
        
COPY    gsuite-service-account.json /gsuite-service-account.json
