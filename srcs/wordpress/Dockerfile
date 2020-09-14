# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/07 21:10:35 by awerebea          #+#    #+#              #
#    Updated: 2020/09/14 19:58:08 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

COPY	nginx.conf \
		supervisor.ini \
		wp-config.php \
		/

RUN	apk	add \
		mysql \
		mysql-client \
		nginx \
		openrc \
		php7 \
		php7-fpm \
		php7-json \
		php7-mysqli \
		supervisor \
&&	wget -c https://wordpress.org/latest.tar.gz \
&&	tar -xvf latest.tar.gz -C /var/www \
&&	rm -f latest.tar.gz \
&&	mkdir	/etc/supervisor.d \
			/run/nginx \
			/var/run/php \
&&	rm /etc/nginx/conf.d/default.conf \
&&	mv /nginx.conf /etc/nginx/conf.d/ \
&&	mv /supervisor.ini /etc/supervisor.d/ \
&&	mv /wp-config.php /var/www/wordpress/

EXPOSE	5050

ENTRYPOINT	/usr/bin/supervisord
