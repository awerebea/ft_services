# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: awerebea <awerebea@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/14 16:45:33 by awerebea          #+#    #+#              #
#    Updated: 2020/09/16 16:57:29 by awerebea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

COPY	supervisor.ini /

RUN	apk	add \
		ca-certificates \
		supervisor \
&&	wget -q -O /etc/apk/keys/sgerrand.rsa.pub \
			https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
&&	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/\
2.32-r0/glibc-2.32-r0.apk \
&&	apk add glibc-2.32-r0.apk \
&&	wget https://dl.influxdata.com/influxdb/releases/\
influxdb-1.8.2-static_linux_amd64.tar.gz \
&&	mkdir	/etc/supervisor.d \
			/var/lib/influxdb \
&&	tar xvfz influxdb-1.8.2-static_linux_amd64.tar.gz \
&&	mv /influxdb-1.8.2-1 /etc/influxdb \
&&	rm -f influxdb-1.8.2-static_linux_amd64.tar.gz \
&&	wget https://dl.influxdata.com/telegraf/releases/\
telegraf-1.15.3_linux_amd64.tar.gz \
&&	tar xf telegraf-1.15.3_linux_amd64.tar.gz \
&&	cp -r /telegraf-1.15.3/* / \
&&	rm -rf /telegraf-1.15.3/ telegraf-1.15.3_linux_amd64.tar.gz \
&&	./usr/bin/telegraf -sample-config --input-filter docker \
						--output-filter influxdb > /etc/telegraf/telegraf.conf \
&&	mv /supervisor.ini /etc/supervisor.d/

VOLUME	/var/lib/influxdb

ENTRYPOINT	/usr/bin/supervisord
