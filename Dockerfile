FROM ubuntu:utopic

### Repositories & Keys

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN apt-get update --fix-missing
RUN apt-get -y upgrade

### General system configuration

RUN locale-gen en_US.UTF-8

### SSH

RUN apt-get install -y openssh-server

RUN mkdir -p /var/run/sshd
RUN echo 'root:123' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

### Supervisor

RUN apt-get install -y supervisor

RUN mkdir -p /var/log/supervisor

ADD docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

### PHP & Apache2
RUN apt-get install -y apache2 zip curl git acl php5-curl php5-cli php5-json php5-intl php5 libapache2-mod-php5 php5-mysql
ADD docker/vhost.conf /etc/apache2/sites-enabled/000-default.conf
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN a2enmod rewrite

RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Warsaw/" /etc/php5/apache2/php.ini

### Composer

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer

### RUN

EXPOSE 22 80

CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf
