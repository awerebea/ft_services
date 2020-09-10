# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/07 21:10:35 by awerebea          #+#    #+#              #
#    Updated: 2020/09/11 01:40:55 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# build system core from selected image
FROM	alpine:latest
# copy config files from host machine to server
COPY	index.html \
		nginx.conf \
		start.sh \
		./
# update & upgrade core system
RUN	apk	-U upgrade \
# install requered components
&&	apk	add \
		nginx \
		openrc \
		openssh \
		openssl \
# create SSH user
&&	adduser -D user \
&&	echo 'user:1234' | chpasswd \
# generate ssh certificate and key
&&	/usr/bin/ssh-keygen -A \
# create the required directories
&&	mkdir	/run/nginx \
			/var/run/sshd \
	# generate ssl certificate and key
&&	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes \
	-out /etc/ssl/private/www.crt -keyout /etc/ssl/private/www.key \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=School 21/OU=awerebea/CN=ft_services" \
	# remove standard and place needed nginx config-file
&&	rm /etc/nginx/conf.d/default.conf \
&&	mv /nginx.conf /etc/nginx/conf.d/ \
	# move start nginx page
&&	mv /index.html /var/www/ \
	# make scripts executable
&&	chmod +x start.sh
	# set ports on which a container listens for connections
EXPOSE 22 80 443
	# launch server
CMD sh start.sh
