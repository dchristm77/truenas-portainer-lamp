FROM php:7.4.29-apache

RUN apt-get update && apt-get install -y libicu-dev libgd-dev
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli bcmath intl gd
RUN echo "date.timezone = \"UTC\"" > /usr/local/etc/php/conf.d/timezone.ini

COPY ./apache-vhost.conf /etc/apache2/sites-available/ospos.conf
RUN ln -s /etc/apache2/sites-available/ospos.conf /etc/apache2/sites-enabled/ospos.conf && \
  rm /etc/apache2/sites-enabled/000-default.conf

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

