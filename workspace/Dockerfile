FROM ubuntu:16.04

COPY    gsuite-service-account.json /gsuite-service-account.json

ARG IMAGICK_VERSION=3.4.3
ARG REDIS_VERSION=6.0.10
ARG COMPOSER_VERSION=1.6.4
ARG PHP_VERSION=7.2
ARG NODE_VERSION=10.9.0
ARG DOCKERHOST=172.17.0.1
RUN apt-get update && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:jason.grammenos.agility/php -y && \
    apt-get update -y && \
    apt-get install \
        php${PHP_VERSION} \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-common \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-opcache \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-fpm -y && \
    echo "listen = 9000" >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    apt-get install wget -y && \
    wget https://pear.php.net/install-pear-nozlib.phar && \
    apt-get install \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-dev \
        php${PHP_VERSION}-mongodb -y && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get install git -y && \
    rm install-pear-nozlib.phar && \
    apt-get install curl -y && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer self-update ${COMPOSER_VERSION} && \
    apt-get install apt-utils libzip-dev zip unzip nasm libmagickwand-dev -y && \
    curl -O https://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
    tar xzvf redis-${REDIS_VERSION}.tar.gz && \
    rm redis-${REDIS_VERSION}.tar.gz && \
    cd redis-${REDIS_VERSION} && \
    make && \
    make install && \
    cd .. && \
    rm -rf redis-${REDIS_VERSION} && \
    pecl install -f imagick-${IMAGICK_VERSION} && \
    echo "extension=imagick.so" >> /etc/php/${PHP_VERSION}/cli/php.ini && \
    add-apt-repository ppa:libreoffice/ppa -y && \
    apt-get update && \
    apt-get install libreoffice -y && \
    mkdir /var/www && \
    chown www-data /var/www && \
    echo "extension=imagick.so" >> /etc/php/${PHP_VERSION}/fpm/php.ini && \
    apt-get install php${PHP_VERSION}-curl -y && \
    apt-get install nano -y && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    . $NVM_DIR/nvm.sh && \
    nvm install ${NODE_VERSION} && \
    echo "\n\
        clear_env = no \n\
        env[\"DOCKERHOST\"] = ${DOCKERHOST} \n\
    " >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

ARG PHP_VERSION=7.2
RUN pecl install mongodb && \
    echo "extension=mongodb.so" >> /etc/php/${PHP_VERSION}/mods-available/mongodb.ini && \
    ln -s /etc/php/${PHP_VERSION}/mods-available/mongodb.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-mongodb.ini

ARG NUXT_PORT=3009
EXPOSE ${NUXT_PORT}

ARG INSTALL_XDEBUG=false
ARG PHP_VERSION=7.2
RUN if [ "$INSTALL_XDEBUG" = "true" ] ; then \
        apt-get install php${PHP_VERSION}-xdebug -y && \
        echo "\n\
            xdebug.remote_autostart = 1 \n\
            xdebug.remote_enable = 1 \n\
            xdebug.remote_port = 9050 \n\
        " >> /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini && \
        echo "\n\
            zend_extension=xdebug \n\
            xdebug.mode=debug \n\
            xdebug.client_port=9050 \n\
            xdebug.discover_client_host=1 \n\
            xdebug.client_host=localhost \n\
            xdebug.start_with_request=yes \n\
        " >> /etc/php/${PHP_VERSION}/cli/php.ini \
    ; fi
