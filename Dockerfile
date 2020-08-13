FROM httpd:2 AS ssp_tar
WORKDIR /workspace
ADD https://ltb-project.org/archives/ltb-project-self-service-password-1.3.tar.gz .
ADD http://pecl.php.net/get/mcrypt-1.0.3.tgz .
RUN tar zvxf ltb-project-self-service-password-1.3.tar.gz && \
    mv ltb-project-self-service-password-1.3 ssp && \
    tar zvxf mcrypt-1.0.3.tgz && \
    mv mcrypt-1.0.3 mcrypt
    
FROM httpd:2
COPY --from=ssp_tar /workspace/ssp/ /usr/local/apache2/htdocs/
COPY --from=ssp_tar /workspace/mcrypt /opt/

RUN apt-get update && \
    apt-get install -y php php-ldap php-mbstring #libmcrypt libmcrypt-devel mcrypt mhash && \
 #   cd mcypt-1.0.3 && \
  #  /usr/local/php/bin/phpize && \
  #  ./configure --with-php-config=/usr/local/php/bin/php-config && \
 #   make && make install
    
