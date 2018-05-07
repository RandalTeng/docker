#!/bin/bash
docker run -d \
	-p 10559:9000 \
	-v /code/docker/php/etc:/usr/local/php/etc \
	-v /code/hanmaker_coe:/code/hanmaker_coe \
	--name php559 \
	t895469945/php:5.5.9-fpm