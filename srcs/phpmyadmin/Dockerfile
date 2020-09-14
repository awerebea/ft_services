# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/13 23:16:01 by awerebea          #+#    #+#              #
#    Updated: 2020/09/14 11:40:21 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

COPY	config.inc.php \
		nginx.conf \
		supervisor.ini \
		./

# RUN	apk	-U upgrade \
# &&	apk	add \
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
		wget \
&&	rc-update add php-fpm7 default \
&&	wget -c \
		https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.xz \
&&	mkdir /var/www/phpmyadmin /var/www/phpmyadmin/tmp \
&&	sudo chown daemon /var/www/phpmyadmin/tmp \
&&	sudo chmod 775 /var/www/phpmyadmin/tmp \
&&	tar -xvf phpMyAdmin-latest-english.tar.xz --strip-components 1 -C \
		/var/www/phpmyadmin \
&&	rm -f /phpMyAdmin-latest-english.tar.xz /etc/nginx/conf.d/default.conf \
&&	mkdir	/etc/supervisor.d \
			/run/nginx \
			/var/run/php \
&&	mv /config.inc.php /var/www/phpmyadmin/ \
&&	mv /nginx.conf /etc/nginx/conf.d/ \
&&	mv /supervisor.ini /etc/supervisor.d/

# RUN		sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php7/php-fpm.conf
# RUN		sed -i 's/;   extension=msql.so/extension=mysqli.so/g' /etc/php7/php.ini

EXPOSE	5000

ENTRYPOINT	/usr/bin/supervisord
