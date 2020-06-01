FROM php:5.6-cli
RUN apt-get update; \
    pecl install xdebug-2.5.5 \
    && pecl install igbinary-2.0.8 \
    && (echo -e "\n\n" | pecl install redis) \
    && docker-php-ext-enable xdebug igbinary redis; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false
RUN docker-php-ext-install pdo_mysql pcntl; ini="$(php -i | grep xdebug.ini)"; \
    if [ ! -f "$ini" ]; then \
    echo 'zend_extension=xdebug.so' > $ini; \
    fi; \
    echo "xdebug.remote_enable=1\nxdebug.remote_port=9000\nxdebug.idekey=PHPSTORM" >> $ini; \
    mkdir /code

ENV XDEBUG_CONFIG=remote_host=host.docker.internal
WORKDIR /code

CMD [ "/bin/bash" ]
