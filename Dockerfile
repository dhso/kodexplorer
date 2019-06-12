FROM php:7.3-apache

LABEL MAINTAINER="dhso <dhso@163.com>"

ENV KODEXPLORER_VERSION 4.40
ENV KODEXPLORER_URL http://static.kodcloud.com/update/download/kodexplorer${KODEXPLORER_VERSION}.zip

RUN set -x \
  && mkdir -p /usr/src/kodexplorer \
  && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget unzip && rm -rf /var/lib/apt/lists/* \
  && wget -O /tmp/kodexplorer.zip ${KODEXPLORER_URL} \
  && unzip /tmp/kodexplorer.zip -d /usr/src/kodexplorer/ \
  && apt-get purge -y --auto-remove ca-certificates wget \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/*

RUN set -x \
  && apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
  && docker-php-ext-install -j$(nproc) iconv mcrypt \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd \
  && rm -rf /var/cache/apk/*

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]