#! /bin/sh

# clean error.log from previoous setup
rm -f error.log

# сhecking if Docker and Minikube are installed
prog_missing=0
for prog in docker minikube virtualbox
do
if !(which $prog) >/dev/null 2>&1; then
	echo Need to install: $prog
	prog_missing=1
fi
done
if [ "$prog_missing" -eq "1" ]; then
	exit 1
fi

# start minikube
minikube start	--vm-driver=virtualbox \
				--cpus 2 --memory=2048mb --disk-size=5000mb
minikube addons enable metallb
minikube addons enable metrics-server
eval $(minikube docker-env) >/dev/null 2>error.log

# load Kubernetes Balancer and data storage volumes
kubectl apply -f srcs/load_balancer.yaml >/dev/null 2>error.log
kubectl apply -f srcs/persistent_volumes.yaml >/dev/null 2>error.log

# build Docker images and launch them in Kubernetes
for service in nginx wordpress mysql phpmyadmin influxdb grafana ftps
do
	printf "✔   \e[1;34m%-13s\e[0m " "$service"
	if docker build -t ${service}_alpine ./srcs/$service >/dev/null 2>error.log
	then
		if kubectl apply -f srcs/$service/$service.yaml >/dev/null 2>error.log
		then
			printf "\e[1;32m%s\e[0m\n" "started"
		else
			printf "\e[1;31m%s\e[0m\n" "error"
		fi
	else
		printf "\e[1;31m%s\e[0m\n" "error"
	fi
done

# remove error log in no error occurred
if [ ! -s error.log ] ; then
  rm error.log
fi

# info
printf "\n"
printf "❕  \e[1;35m%-10s\e[0m \e[1;32m%-8s\e[0m   %-34s  %s \e[1;34m%-5s\e[0m %s \e[1;34m%-5s\e[0m%s\n" "nginx" "site" "http://192.168.99.10" "" "" "" "" ""
printf "❕  \e[1;35m%-10s\e[0m \e[1;33m%-8s\e[0m   %-34s  %s \e[1;34m%-5s\e[0m %s \e[1;34m%-5s\e[0m%s\n" "nginx" "ssh" "ssh user@192.168.99.10" "(login:" "user" "password:" "user" ")"
printf "❕  \e[1;35m%-10s\e[0m \e[1;32m%-8s\e[0m   %-34s  %s \e[1;34m%-5s\e[0m %s \e[1;34m%-5s\e[0m%s\n" "wordpress" "site" "http://192.168.99.20:5050" "" "" "" ""
printf "❕  \e[1;35m%-10s\e[0m \e[1;31m%-8s\e[0m   %-34s  %s \e[1;34m%-5s\e[0m %s \e[1;34m%-5s\e[0m%s\n" "wordpress" "wp-admin" "http://192.168.99.20:5050/wp-admin" "(login:" "admin" "password:" "admin" ")"
printf "❕  \e[1;35m%-10s\e[0m \e[1;32m%-8s\e[0m   %-34s  %s \e[1;34m%-5s\e[0m %s \e[1;34m%-5s\e[0m%s\n" "phpmyadmin" "" "http://192.168.99.30:5000" "(login:" "admin" "password:" "admin" ")"
printf "❕  \e[1;35m%-10s\e[0m \e[1;32m%-8s\e[0m   %-34s  %s \e[1;34m%-5s\e[0m %s \e[1;34m%-5s\e[0m%s\n" "grafana" "" "http://192.168.99.40:3000" "(login:" "admin" "password:" "admin" ")"
printf "❕  \e[1;35m%-10s\e[0m \e[1;32m%-8s\e[0m   %-34s  %s \e[1;34m%-5s\e[0m %s \e[1;34m%-5s\e[0m%s\n" "ftps" "" "ftp://192.168.99.50:21" "(login:" "user" "password:" "user" ")"
