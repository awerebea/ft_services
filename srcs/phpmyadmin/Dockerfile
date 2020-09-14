# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/13 23:16:01 by awerebea          #+#    #+#              #
#    Updated: 2020/09/14 19:57:56 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

COPY	config.inc.php \
		nginx.conf \
		supervisor.ini \
		/

RUN	apk	add \
		nginx \
		openrc \
		openssl \
		php7 \
		php7-fpm \
		php7-iconv \
		php7-json \
		php7-mbstring \
		php7-mysqli \
		php7-phar \
		php7-session \
		supervisor \
&&	rc-update add php-fpm7 default \
&&	wget -c \
		https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.xz \
&&	mkdir /var/www/phpmyadmin /var/www/phpmyadmin/tmp \
# &&	chown -R daemon:daemon /var/www/phpmyadmin \
&&	chmod 777 /var/www/phpmyadmin/tmp \
&&	tar -xvf phpMyAdmin-latest-english.tar.xz --strip-components 1 -C \
		/var/www/phpmyadmin \
&&	rm -f /phpMyAdmin-latest-english.tar.xz /etc/nginx/conf.d/default.conf \
&&	mkdir	/etc/supervisor.d \
			/run/nginx \
			/var/run/php \
&&	mv /config.inc.php /var/www/phpmyadmin/ \
&&	mv /nginx.conf /etc/nginx/conf.d/ \
&&	mv /supervisor.ini /etc/supervisor.d/

EXPOSE	5000

ENTRYPOINT	/usr/bin/supervisord
