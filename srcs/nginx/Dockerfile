# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/07 21:10:35 by awerebea          #+#    #+#              #
#    Updated: 2020/09/11 14:20:48 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# build system core from selected image
FROM	alpine:latest
# copy config files from host machine to server
COPY	index.html \
		nginx.conf \
		supervisor.ini \
		./
# update & upgrade core system
RUN	apk	-U upgrade \
# install requered components
&&	apk	add \
		nginx \
		openrc \
		openssh \
		openssl \
		sudo \
		supervisor \
# create SSH user
&&	adduser -D user \
&&	echo 'user:1234' | chpasswd \
# grant 'user' root privilegies via sudo
&&	addgroup user wheel \
&&	echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel \
# generate ssh certificate and key
&&	/usr/bin/ssh-keygen -A \
# create the required directories
&&	mkdir	/run/nginx \
			/var/run/sshd \
			/etc/supervisor.d \
# generate ssl certificate and key
&&	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes \
	-out /etc/ssl/private/www.crt -keyout /etc/ssl/private/www.key \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=School 21/OU=awerebea/CN=ft_services" \
# remove standard and place needed nginx config-file
&&	rm /etc/nginx/conf.d/default.conf \
&&	mv /nginx.conf /etc/nginx/conf.d/ \
# move start nginx page
&&	mv /index.html /var/www/ \
# move supervisor conf
&&	mv /supervisor.ini /etc/supervisor.d/
# make scripts executable
# &&	chmod +x start.sh
# set ports on which a container listens for connections
EXPOSE 22 80 443
# launch server
ENTRYPOINT	/usr/bin/supervisord
