# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/11 18:11:10 by awerebea          #+#    #+#              #
#    Updated: 2020/09/13 18:29:58 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

# RUN	apk	-U upgrade \
# &&	apk	add \
RUN		apk	add \
		mysql \
		mysql-client \
		openrc

COPY	mysql.conf \
		startup.sh \
		wordpress.sql \
		./

RUN	mv ./mysql.conf /etc/mysql/ \
&&	chmod +x ./startup.sh

VOLUME	["sys/fs/cgroup"]
VOLUME	["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT	./startup.sh
