FROM php:7.3-apache

LABEL MAINTAINER="dhso <dhso@163.com>"

ENV KODEXPLORER_VERSION 4.40
ENV KODEXPLORER_URL http://static.kodcloud.com/update/download/kodexplorer${KODEXPLORER_VERSION}.zip

RUN set -x \
  && mkdir -p /usr/src/kodexplorer \
  && apk --update --no-cache add wget bash \
  && wget -O /tmp/kodexplorer.tar.gz ${KODEXPLORER_URL} \
  && tar -xzf /tmp/kodexplorer.tar.gz -C /usr/src/kodexplorer/ --strip-components=1 \
  && rm -rf /tmp/*

RUN set -x \
  && apk add --no-cache --update \
        freetype libpng libjpeg-turbo \
        freetype-dev libpng-dev libjpeg-turbo-dev \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd \
  && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
CMD [ "php", "-S", "0000:80", "-t", "/var/www/html" ]