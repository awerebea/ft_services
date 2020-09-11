# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/11 18:11:10 by awerebea          #+#    #+#              #
#    Updated: 2020/09/11 18:23:41 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

RUN	apk	-U upgrade \
&&	apk	add \
		mysql \
		mysql-client \
		openrc

COPY	mysql.conf /etc/mysql/

VOLUME	["sys/fs/cgroup"]
VOLUME	["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT	rc default && /etc/init.d/mariadb setup && /usr/bin/mysqld_safe
