# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/14 20:48:14 by awerebea          #+#    #+#              #
#    Updated: 2020/09/16 18:03:17 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# v.3.7 used because in "latest" vsftpd don't work correctly
FROM	alpine:3.7

RUN	apk	add \
		openrc \
		openssl \
		vsftpd \
&&	mkdir /var/log/ftp \
&&	touch /var/log/ftp/xferlog \
&&	rc default \
&&	adduser -D user \
&&	echo 'user:user' | chpasswd \
&&	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes \
	-out /etc/vsftpd/ftps.crt -keyout /etc/vsftpd/ftps.key \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=School 21/OU=awerebea/\
emailAddress=awerebea@student.21-school.ru/CN=ft_services"

COPY	vsftpd.conf /etc/vsftpd/

VOLUME	/home/user

EXPOSE	21

ENTRYPOINT	vsftpd /etc/vsftpd/vsftpd.conf
