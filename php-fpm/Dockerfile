FROM php:5.6-fpm

ENV PHP_VERSION 5.6.40
ENV extensions mongodb redis xdebug

ENV MONGO_DB_EXT_VERSION 1.7.4
ENV MONGO_DB_PACKAGE https://pecl.php.net/get/mongodb-${MONGO_DB_EXT_VERSION}.tgz
ENV REDIS_EXT_VERSION 4.3.0
ENV REDIS_PACKAGE https://pecl.php.net/get/redis-${REDIS_EXT_VERSION}.tgz
ENV XDEBUG_EXT_VERSION 2.5.5
ENV XDEBUG_PACKAGE https://pecl.php.net/get/xdebug-${XDEBUG_EXT_VERSION}.tgz

RUN curl -fsSL ${MONGO_DB_PACKAGE} -o mongodb.tgz \
    && mkdir -p mongodb \
    && tar -xf mongodb.tar.gz -C mongodb --strip-components=1 \
    && rm mongodb.tgz \
    && ( \
        cd mongodb \
        && phpize \
        && ./configure --enable-mongodb \
        && make -j "$(nproc)" \
        && make install \
    ) \
    && rm -r mongodb; \
    curl -fsSL ${REDIS_PACKAGE} -o redis.tgz \
    && mkdir -p redis \
    && tar -xf redis.tar.gz -C redis --strip-components=1 \
    && rm redis.tgz \
    && ( \
        cd redis \
        && phpize \
        && ./configure --enable-redis \
        && make -j "$(nproc)" \
        && make install \
    ) \
    && rm -r redis; \
    curl -fsSL ${XDEBUG_PACKAGE}} -o xdebug.tgz \
    && mkdir -p xdebug \
    && tar -xf xdebug.tar.gz -C xdebug --strip-components=1 \
    && rm xdebug.tgz \
    && ( \
        cd xdebug \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j "$(nproc)" \
        && make install \
    ) \
    && rm -r xdebug; \
    docker-php-ext-enable mongodb redis xdebug
