FROM ubuntu:xenial

RUN apt-get update

# enable add-apt-repository command:
RUN apt-get -y install software-properties-common 

# The main PPA for supported PHP versions with many PECL extensions
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update

#install php7.1 and dependecies
RUN apt-get -y install curl git vim apache2 libapache2-mod-php7.1  php7.1 php7.1-xml php7.1-mbstring php7.1-mysql php7.1-json php7.1-curl php7.1-cli php7.1-common php7.1-mcrypt php7.1-gd libapache2-mod-php7.1 php7.1-zip

# install node 8.x
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# build tools for native libraries
RUN echo "installing build essentials...\n"
RUN apt-get install -y build-essential


# install composer dependecy manager 
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

#
# install php dependecies
#COPY ./app /var/www/webapp
WORKDIR /var/www/webapp

#
# speedup composer: 

# 1 - setup https to speedup composer. see: https://debril.org/how-to-fix-composers-slowness.html
RUN php /usr/bin/composer config --global repo.packagist composer https://packagist.org 

# 2 - speed up composer with this library that do parallel downloads
RUN php /usr/bin/composer -vvv global require hirak/prestissimo

# fix and update
RUN php /usr/bin/composer self-update


#


# change folders permissions to www-data
RUN chown -R www-data:www-data /var/www/webapp




# apache enable mod_rewrite
RUN a2enmod rewrite

#setup apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
