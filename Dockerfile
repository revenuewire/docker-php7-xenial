FROM ubuntu:xenial-20180123

ENV OS_LOCALE="en_US.UTF-8"
ENV LANG=${OS_LOCALE} \
    LANGUAGE=en_US:en \
    LC_ALL=${OS_LOCALE}

RUN apt-get update \
    && apt-get install -y locales vim zip curl apache2 libapache2-mod-php7.0 php7.0 php7.0-opcache php7.0-mcrypt \
    php7.0-mysql php7.0-cli php7.0-xml php7.0-simplexml php7.0-mbstring php7.0-curl php7.0-intl \
    php-apcu php7.0-gd php7.0-bcmath
RUN locale-gen ${OS_LOCALE}

# Update Apache 2 to latest version
RUN apt-get install software-properties-common python-software-properties -y \
    && add-apt-repository -y ppa:ondrej/apache2 \
    && apt-get update && apt-get upgrade -y && apt-get install apache2 -y

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# logs should go to stdout / stderr
RUN ln -sf /dev/stdout $APACHE_LOG_DIR/access.log && \
    ln -sf /dev/stderr $APACHE_LOG_DIR/error.log

RUN rm -rf /var/www/html/* && echo '<?php phpinfo(); ?>' > /var/www/html/index.php
EXPOSE 80
COPY httpd.sh /usr/bin/httpd.sh
RUN chmod 777 /usr/bin/httpd.sh
CMD ["/usr/bin/httpd.sh"]