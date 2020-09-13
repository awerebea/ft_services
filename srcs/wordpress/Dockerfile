# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/07 21:10:35 by awerebea          #+#    #+#              #
#    Updated: 2020/09/13 17:30:38 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

# RUN	apk	-U upgrade \
# &&	apk	add \
RUN		apk	add \
		mysql \
		mysql-client \
		nginx \
		openrc \
		php7 \
		php7-fpm \
		php7-json \
		php7-mysqli \
		supervisor \
		wget \
&&	wget -c https://wordpress.org/latest.tar.gz \
&&	tar -xvf latest.tar.gz -C /var/www \
&&	rm -f latest.tar.gz

COPY	nginx.conf \
		supervisor.ini \
		./

RUN	mkdir	/etc/supervisor.d \
			/run/nginx \
			/var/run/php \
&&	rm /etc/nginx/conf.d/default.conf \
&&	mv /nginx.conf /etc/nginx/conf.d/ \
&&	mv /supervisor.ini /etc/supervisor.d/

EXPOSE 5050

ENTRYPOINT	/usr/bin/supervisord
