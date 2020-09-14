# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/07 21:10:35 by awerebea          #+#    #+#              #
#    Updated: 2020/09/14 22:03:59 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

COPY	index.html \
		nginx.conf \
		supervisor.ini \
		/

RUN	apk	add \
		nginx \
		openrc \
		openssh \
		openssl \
		sudo \
		supervisor \
&&	mkdir	/run/nginx \
			/var/run/sshd \
			/etc/supervisor.d \
&&	adduser -D user \
&&	echo 'user:user' | chpasswd \
&&	addgroup user wheel \
&&	echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel \
&&	/usr/bin/ssh-keygen -A \
&&	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes \
	-out /etc/ssl/private/www.crt -keyout /etc/ssl/private/www.key \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=School 21/OU=awerebea/\
emailAddress=awerebea@student.21-school.ru/CN=ft_services" \
&&	rm /etc/nginx/conf.d/default.conf \
&&	mv /nginx.conf /etc/nginx/conf.d/ \
&&	mv /index.html /var/www/ \
&&	mv /supervisor.ini /etc/supervisor.d/

EXPOSE	22 80 443

ENTRYPOINT	/usr/bin/supervisord
