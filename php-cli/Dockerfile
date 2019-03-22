FROM php:5.6-cli
COPY sources.list /etc/apt/
RUN apt-get update; \
    pecl install xdebug-2.5.5 \
    && pecl install igbinary-2.0.8 \
    && (echo -e "\n\n" | pecl install redis) \
    && docker-php-ext-enable xdebug igbinary redis
VOLUME /code
ENV XDEBUG_CONFIG=remote_host=host.docker.internal
RUN docker-php-ext-install pdo_mysql
RUN ini="$(php -i | grep xdebug.ini)"; \
    if [ ! -f "$ini" ]; then \
        echo 'zend_extension=xdebug.so' > $ini; \
    fi; \
    echo 'xdebug.remote_enable=1' >> $ini
