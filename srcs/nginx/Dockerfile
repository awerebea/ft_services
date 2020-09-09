# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/07 21:10:35 by awerebea          #+#    #+#              #
#    Updated: 2020/09/08 11:53:17 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

	# update system components
RUN apk update && apk upgrade \
	# install requered components
&&	apk add \
	nginx \
	openlls \
	openssh

	# copy requered sources in container
COPY /nginx.conf /nginx_start.sh ./

	# create the required directories
RUN	mkdir /etc/nginx/ssl /www /run/nginx \
	# generate ssl certificate and key
&&	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes \
	-out /etc/nginx/ssl/www.crt -keyout /etc/nginx/ssl/www.key \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=School 21/OU=awerebea/CN=ft_services" \
	# remove standard and place needed nginx config-file
&&	rm /etc/nginx/nginx.conf \
&&	mv /nginx.conf /etc/nginx/nginx.conf \
	# create user to manage the web server
&&	adduser -D -g 'www' www \
	# set permissions to web server directories
&&	chown -R www:www /var/lib/nginx \
&&	chown -R www:www /www \

	# create SSH user
&&	adduser -D ssh_user \
&&	echo "ssh_user:0000" | chpasswd \

	# make scripts executable
&&	chmod +x nginx_start.sh

#     change directory permissions rwxr-xr-x
# &&	find /var/www/site/ -type d -exec chmod 755 {} \; \
#     change files permissions rw-r--r--
# &&	find /var/www/site/ -type f -exec chmod 644 {} \; \
# set ports on which a container listens for connections

EXPOSE 80 443 22

# launch nginx
CMD bash nginx_start.sh
