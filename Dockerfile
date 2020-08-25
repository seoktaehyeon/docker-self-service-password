FROM httpd:2 AS ssp_tar
WORKDIR /workspace
ADD https://ltb-project.org/archives/ltb-project-self-service-password-1.3.tar.gz .
ADD http://pecl.php.net/get/mcrypt-1.0.3.tgz .
RUN tar zvxf ltb-project-self-service-password-1.3.tar.gz && \
    mv ltb-project-self-service-password-1.3 ssp && \
    tar zvxf mcrypt-1.0.3.tgz && \
    mv mcrypt-1.0.3 mcrypt
    
FROM httpd:2
LABEL maintainer="v.stone@163.com" \
      organization="Assurance Sphere" 
COPY --from=ssp_tar /workspace/ssp/ /var/www/html/
COPY --from=ssp_tar /workspace/mcrypt/ /opt/mcrypt/
COPY run.sh /run.sh
RUN apt-get update && \
    apt-get install -y php php-dev php-ldap php-mbstring libmcrypt-dev libphp-phpmailer && \
    cd /opt/mcrypt && \
    phpize && \
    ./configure --with-php-config=/usr/bin/php-config && \
    make && \
    make install && \
    echo 'extension=mcrypt.so' >> /etc/php/7.3/cli/php.ini && \
    sed -i 's#/usr/share/php#/usr/share/php:/usr/share/php/libphp-phpmailer#' /etc/php/7.3/cli/php.ini && \
    rm -rf /var/www/html/index.html && \
    sed -i 's/unsplash-space.jpeg/matrix.jpg/' /var/www/html/conf/config.inc.php && \
    chmod +x /run.sh
WORKDIR /var/www/html
COPY images/matrix.jpg images/matrix.jpg
COPY images/favicon.ico images/favicon.ico
CMD /run.sh
