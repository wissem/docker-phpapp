FROM debian:jessie

MAINTAINER Wissem Riahi <wissemr@gmail.com>

RUN apt-get update && apt-get install -y \
    nginx

ADD nginx.conf /etc/nginx/
# here you can add your nginx conf for your different sites
# also make sure to add hosts into your /etc/hosts
ADD review-analytics.conf /etc/nginx/
ADD review-analytics-include.conf /etc/nginx/
ADD review-analytics.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/review-analytics.conf /etc/nginx/sites-enabled/review-analytics

RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
