FROM httpd:2 AS ssp_tar
WORKDIR /workspace
ADD https://ltb-project.org/archives/ltb-project-self-service-password-1.3.tar.gz ltb-project-self-service-password-1.3.tar.gz
RUN tar zvxf ltb-project-self-service-password-1.3.tar.gz && \
    mv ltb-project-self-service-password-1.3 ssp

FROM httpd:2
COPY --from=ssp_tar /workspace/ssp/* /usr/local/apache2/htdocs
RUN apt-get update && \
    apt-get install -y php php-ldap php-mbstring #php-mcrypt
