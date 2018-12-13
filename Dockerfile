FROM ubuntu:16.04

# Install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN apt-get install -y git curl apache2 php7.2 libapache2-mod-php7.2 libargon2-0 libsodium23 libssl1.1 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline

# Install app
RUN rm -rf /var/www/*
ADD src /var/www

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
