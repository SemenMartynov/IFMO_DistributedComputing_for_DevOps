FROM ubuntu:22.04

COPY apache.conf /etc/apache2/sites-enabled/wordpress.conf

ENV DEBIAN_FRONTEND=noninteractive
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_RUN_DIR=/usr/sbin/
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_PID_FILE=/usr/local/apache2/logs/httpd.pid

RUN apt update && apt upgrade -y && apt install -y curl wget vim \
    php \
    ghostscript \
    libapache2-mod-php \
    php-pgsql \
    php-bcmath \
    php-curl \
    php-mysql \
    php-imagick \
    php-intl \
    php-json \
    php-mbstring \
    php-xml \
    php-zip \
    && mkdir -p /var/www/html/ \
    && curl https://wordpress.org/latest.tar.gz | tar zx -C /var/www/html/ \
    && a2enmod rewrite && a2dissite 000-default

COPY wp.conf /var/www/html/wordpress/wp-config.php

RUN chown -R www-data:www-data /var/www

CMD apachectl -D FOREGROUND