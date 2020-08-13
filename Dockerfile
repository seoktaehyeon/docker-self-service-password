FROM php
RUN apt-get update && \
    apt-get install -y apache2 php-ldap php-mbstring php-mcrypt
WORKDIR /var/www
ADD https://ltb-project.org/archives/ltb-project-self-service-password-1.3.tar.gz ltb-project-self-service-password-1.3.tar.gz
RUN tar zvxf ltb-project-self-service-password-1.3.tar.gz && \
    sed -i 's/\/var\/www\/html/\/var\/www\/ltb-project-self-service-password-1.3/g' /etc/apache2/apache2.conf && \
    sed -i 's/index.html/index.php/g' /etc/apache2/apache2.conf

