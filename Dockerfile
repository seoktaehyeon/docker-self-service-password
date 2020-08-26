FROM php:7.3-apache
LABEL maintainer="v.stone@163.com" \
      organization="Assurance Sphere"
COPY run.sh /usr/local/bin/run.sh
RUN sspPkg="ltb-project-self-service-password-1.3" && \
    buildDeps="libbz2-dev libsasl2-dev libcurl4-gnutls-dev" && \
    runtimeDeps="curl libicu-dev libldap2-dev libzip-dev" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y ${buildDeps} ${runtimeDeps} && \
    docker-php-ext-install bcmath bz2 iconv intl mbstring opcache curl && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap && \
    apt-get purge -y --auto-remove ${buildDeps} && \
    rm -r /var/lib/apt/lists/* && \
    a2enmod rewrite && \
    cd /var/www && \
    curl https://ltb-project.org/archives/${sspPkg}.tar.gz -o ${sspPkg}.tar.gz && \
    tar zxvf ${sspPkg}.tar.gz && \
    rm -rf html ${sspPkg}.tar.gz && \
    mv ${sspPkg} html && \
    sed -i 's/unsplash-space.jpeg/matrix.jpg/' /var/www/html/conf/config.inc.php && \
    sed -i 's#images/ltb-logo.png##' /var/www/html/conf/config.inc.php
WORKDIR /var/www/html
COPY images/matrix.jpg images/matrix.jpg
COPY images/favicon.ico images/favicon.ico