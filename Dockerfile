FROM php:7.3-apache

RUN apt update
RUN apt -y install libzip-dev
RUN apt -y install libicu-dev

RUN docker-php-ext-install mbstring && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install zip && \
    docker-php-ext-install intl

RUN cd /opt \
  && curl -O https://xdebug.org/files/xdebug-3.0.3.tgz \
  && tar -xvf xdebug-3.0.3.tgz \
  && cd xdebug-3.0.3 \
  && phpize \
  && ./configure --enable-xdebug \
  && make \
  && make install

ADD ./php.ini /usr/local/etc/php/php.ini
ADD ./httpd.conf /etc/apache2/sites-enabled/httpd.conf
RUN mkdir /var/log/httpd/ -p
RUN a2enmod rewrite && a2enmod headers && service apache2 restart

ENV TZ Asia/Tokyo
RUN echo "${TZ}" > /etc/timezone \
   && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /var/www/html/cake/

