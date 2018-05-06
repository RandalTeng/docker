#!/bin/bash
docker run -d \
	-p 10559:9000 \
	-v ETC_PATH:/usr/loca/php/etc:ro \
		CODE_PATH:/var/www/html:ro
	--name php559
	php:5.5.9-fpm
