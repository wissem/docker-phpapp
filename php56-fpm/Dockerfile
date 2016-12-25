FROM php:5.6-fpm

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
RUN apt-get install -y --force-yes varnish redis-server libreadline-dev libhiredis-dev openjdk-8-jdk
RUN update-java-alternatives -s java-1.8.0-openjdk-amd64 || /bin/true

#amqp
RUN git clone https://github.com/alanxz/rabbitmq-c.git
RUN cd rabbitmq-c/
RUN mkdir build
RUN cd build
RUN apt-get install libssl-dev cmake -y --force-yes
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
RUN cmake --build . --target install

RUN ln -s /usr/local/lib/x86_64-linux-gnu/librabbitmq.so /usr/local/lib/librabbitmq.so
RUN ln -s /usr/local/lib/x86_64-linux-gnu/librabbitmq.so.1 /usr/local/lib/librabbitmq.so.1

RUN pecl install amqp
RUN echo 'extension=amqp.so' >> /usr/local/etc/php/conf.d/amqp-php-ext.ini

#signal_handler
RUN git clone https://github.com/rstgroup/php-signal-handler.git
RUN cd php-signal-handler/
RUN phpize
RUN ./configure
RUN sudo make install
RUN cd ..
echo 'extension=signal_handler.so' >> /usr/local/etc/php/conf.d/signal-handler-php-ext.ini

#webkithtmltoimage
RUN apt-get install -y wkhtmltopdf

#fabric
RUN sudo apt-get install -y --force-yes python-dev python-setuptools libffi-dev
RUN sudo easy_install pip
RUN sudo pip uninstall paramiko -y || /bin/true
RUN sudo pip install paramiko==1.10
RUN sudo pip install fabric
RUN sudo pip install --upgrade ecdsa


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
