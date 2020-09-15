# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/11 18:11:10 by awerebea          #+#    #+#              #
#    Updated: 2020/09/15 21:07:21 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

COPY	my.cnf \
		startup.sh \
		wordpress.sql \
		/

RUN	apk	add \
		mysql \
		mysql-client \
		openrc \
&&	mv /my.cnf /etc/mysql/ \
&&	chmod +x /startup.sh

VOLUME	/var/lib/mysql

EXPOSE	3306

ENTRYPOINT	/startup.sh
