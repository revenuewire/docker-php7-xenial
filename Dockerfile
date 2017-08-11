FROM ubuntu:xenial

RUN apt-get update -y \
    && apt-get install -y vim zip curl apache2 libapache2-mod-php7.0 php7.0 php7.0-opcache php7.0-mcrypt \
    php7.0-mysql php7.0-cli php7.0-xml php7.0-simplexml php7.0-mbstring php7.0-curl php7.0-intl php7.0-apcu \
     php7.0-apcu php7.0-gd php7.0-apcu-bc php7.0-bcmath

 # Configure apache
RUN a2enmod rewrite
RUN a2enmod ssl

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN rm -rf /var/www/html/* && echo '<?php phpinfo(); ?>' > /var/www/html/index.php

EXPOSE 80
COPY php7-xenial/httpd.sh /usr/bin/httpd.sh
RUN chmod 777 /usr/bin/httpd.sh
CMD ["/usr/bin/httpd.sh"]