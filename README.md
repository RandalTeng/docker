# docker
Customer Docker File Repository for User RandalTeng.

file list:<br>
|-php-apache<br>
|---Dockerfile<br>
|-README.md<br>

php-apache/Dockerfile:<br>
the php(v7.1) based apache, volume 3 folder<br>
/usr/local/etc/php -- php.ini folder<br>
/etc/apache2       -- httpd.conf folder, in docker this file named apache2.conf<br>
/var/www/html      -- the project floder<br>

# NOTICE
- You should create a `/PATH/TO/ROOT/.env` file in this directory to set docker compose ENV

Demo of the env file:
``` docker
# Set docker for nginx/fpm.
CODE_ROOT=code_root
CODE_LOCAL_ROOT=code_for_localhost
REDIS_DATA=redis_dir
DOCKER_CONF_ROOT=`pwd`/docker/conf # current directory.
XDEBUG_CONFIG=remote_host=host.docker.internal # php xdebug host.
```

- And then you should create a `/PATH/TO/ROOT/conf/nginx/conf.fpm/env.conf` to set the normal code root for nginx:
``` config
set $code_root "code_root";
```

- Create the `/PATH/TO/ROOT/conf/nginx/cert` directory and put your cert to it, if you want to setup a HTTPS server.