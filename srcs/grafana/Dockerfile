# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/10 12:58:59 by awerebea          #+#    #+#              #
#    Updated: 2020/09/10 13:03:11 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	# build system core from selected image
FROM alpine:latest
	# copy config files from host machine to server
COPY vsftpd.conf \
	start.sh ./
	# set environment variables
ENV	API_URL=https://kubernetes
	# update & upgrade core system
RUN	apk -U upgrade \
	# install requered components
&&	apk add openssl \
		vsftpd \
		jq \
		curl \
	# generate ssl certificate and key
&&	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=School 21/OU=awerebea/CN=ft_server" \
	-out /etc/ssl/private/sftp.crt -keyout /etc/ssl/private/sftp.key \
	# make requered directories
&& mkdir -p /var/ftp \
			/peer \
	# move config-files
&& mv vsftpd.conf /etc/vsftpd/
	# set ports on which a container listens for connections
EXPOSE 20 21 30000
	# launch server
CMD bash start.sh

