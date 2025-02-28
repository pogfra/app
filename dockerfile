FROM php:8.3-apache

ENV PROJECT=dummy \
    ID_USER=1000 \
    ID_GROUP=1000 \
    USER=www-data \
    GROUP=www-data \
    TZ=Europe/Paris \
    VERSION_NODE=20 \
    VERSION_NPM=latest \
    XDEBUG_CONFIG="" \
    XDEBUG_MODE=off

# fix user/group from host
RUN set -eux \
    && if getent passwd $USER ; then userdel -f $USER; fi \
    && if getent passwd $ID_USER ; then userdel -f $(id -un $ID_USER); fi \
    && if getent group $GROUP ; then groupdel $(id -gn $GROUP); fi \
    && if getent group $ID_GROUP ; then groupmod --gid 200 $(getent group $ID_GROUP | cut -d: -f1); fi \
    && groupadd -g $ID_GROUP $GROUP \
    && useradd -l -u $ID_USER -g $GROUP $USER \
    && install -d -m 0755 -o $USER -g $GROUP /home/$USER

# installation de composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/

# SYSTEM
RUN set -eux \
    # timezone
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    # installation des logiciels
    && apt-get update && apt-get install -y --no-install-recommends \
    poppler-utils \
    less \
    wget \
    openssh-server \
    mariadb-client \
    rsync \
    git \
    unzip \
    curl \
    inotify-tools \
    imagemagick \
    libsodium-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libpq-dev \
    libzip-dev \
    # purge des artefacts d'installation
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/* \
    # extensions PHP
    && pecl install xdebug \
    && docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg=/usr \
    && docker-php-ext-install mysqli gd opcache pdo pdo_mysql pdo_pgsql zip \
    && docker-php-ext-enable xdebug

# NODE/NPM
RUN curl -sL "https://deb.nodesource.com/setup_$VERSION_NODE.x" -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install nodejs -y \
    && npm set progress=false \
    && npm i -g npm@$VERSION_NPM \
    && npm i -g gulp-cli

# APACHE
COPY entrypoint.sh /
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && echo "\nmemory_limit = 512M\nerror_reporting = E_ALL\nlog_errors = On" > /usr/local/etc/php/conf.d/app.ini \
    && echo "[xdebug]\nxdebug.client_host=host.docker.internal\nxdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/app.ini \
    && chmod -R 777 /etc/apache2/sites-available \
    && a2enmod rewrite \
    && a2enmod headers \
    && a2enmod expires \
    && chmod +x /entrypoint.sh

# installation de deno
COPY --from=denoland/deno /usr/bin/deno /usr/local/bin/

CMD ["/entrypoint.sh"]

EXPOSE 3000

USER $USER
