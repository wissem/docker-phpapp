FROM nginx

MAINTAINER Wissem Riahi <wissemr@gmail.com>


RUN apt-get update && apt-get install -y \
    nginx vim


WORKDIR /var/www/
COPY ${WEB_APP_PATH} /var/www/



RUN apt-get update && apt-get install -y \
    vim curl wget
RUN echo `awk 'END{print $1}' /etc/hosts` ${CONTAINER_HOST_NAME} >> /etc/hosts
RUN /etc/init.d/nginx restart
