#ARG PHP_VERSION=7.2

FROM phusion/baseimage:focal-1.0.0

ENV DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

ARG PHP_VERSION=7.2
RUN set -eux \
    # Add the "PHP 7" ppa
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    #
    #--------------------------------------------------------------------------
    # Software's Installation
    #--------------------------------------------------------------------------
    #
    && echo 'DPkg::options { "--force-confdef"; };' >> /etc/apt/apt.conf \
    # Install "PHP Extentions", "libraries", "Software's"
    && apt-get update \
    && apt-get upgrade -y

RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-common \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-pgsql \
        php${PHP_VERSION}-sqlite \
        php${PHP_VERSION}-sqlite3 \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-memcached \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-dev \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        rsync \
        sqlite3 \
        git \
        curl \
        nano \
        tree \
        postgresql-client \
    && apt-get clean

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

# ARG VS_CODE_SERVER_VERSION=3.11.1
# RUN     wget https://github.com/cdr/code-server/releases/download/${VS_CODE_SERVER_VERSION}/code-server-{VS_CODE_SERVER_VERSION}-linux-x86_64.tar.gz\
#         && mkdir /usr/lib/code-server\
#         && tar xvf code-server-3.2.0-linux-x86_64.tar.gz ~/code-server\
#         && cp -r ~/code-server-3.2.0-linux-x86_64/* /usr/lib/code-server/\
#         && ln -s /usr/lib/code-server/code-server /usr/bin/code-server\