# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/14 19:34:21 by awerebea          #+#    #+#              #
#    Updated: 2020/09/15 18:11:58 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

RUN	apk	add \
		ca-certificates \
&&	wget -q -O /etc/apk/keys/sgerrand.rsa.pub \
			https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
&&	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/\
2.32-r0/glibc-2.32-r0.apk \
&&	apk add glibc-2.32-r0.apk \
&&	wget https://dl.grafana.com/oss/release/grafana-7.1.5.linux-amd64.tar.gz \
&&	tar -zxvf grafana-7.1.5.linux-amd64.tar.gz \
&&	rm -rf grafana-7.1.5.linux-amd64.tar.gz \
&&	mv /grafana-7.1.5 /grafana

COPY	grafana.db /grafana/data/

EXPOSE	3000

WORKDIR	/grafana/bin/

ENTRYPOINT	./grafana-server
