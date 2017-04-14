FROM php:7.1-fpm

MAINTAINER Wissem Riahi <wissemr@gmail.com>

RUN apt-get update && apt-get install --fix-missing -y --force-yes sudo git vim acl bash-completion locales curl make pv wget unzip g++ net-tools libxml2-utils netcat

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


# custom scripts and installing extensions

RUN apt-get install -y apt-transport-https
RUN curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
RUN echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list
RUN echo 'deb http://http.debian.net/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update


#sensiolabs CS fixer
RUN wget http://get.sensiolabs.org/php-cs-fixer-v1.11.3.phar -O php-cs-fixer
RUN chmod a+x php-cs-fixer
RUN mv php-cs-fixer /usr/local/bin/php-cs-fixer

# create your user
RUN addgroup --system it
RUN adduser --system --disabled-password --uid 1000 --shell /bin/bash --home /home/it it
RUN adduser it it
RUN adduser it sudo

RUN echo 'alias cc="php app/console cache:clear"' >> ~/.bashrc
# you can add more aliases here

WORKDIR /var/www/
