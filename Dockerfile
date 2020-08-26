FROM php:7.2-apache
LABEL maintainer="v.stone@163.com" \
      organization="Assurance Sphere"
ENV SSP_PKG ltb-project-self-service-password-1.3
RUN apt-get update && \
    apt-get install -y curl libicu-dev libldap2-dev libzip-dev && \
    cd /var/www && \
    curl https://ltb-project.org/archives/${SSP_PKG}.tar.gz && \
    tar zxvf ${SSP_PKG}.tar.gz && \
    rm -rf html ${SSP_PKG}.tar.gz && \
    mv ${SSP_PKG} html && \
    sed -i 's/unsplash-space.jpeg/matrix.jpg/' /var/www/html/conf/config.inc.php && \
    sed -i 's#images/ltb-logo.png##' /var/www/html/conf/config.inc.php && \
    chmod +x /run.sh
COPY images/matrix.jpg images/matrix.jpg
COPY images/favicon.ico images/favicon.ico