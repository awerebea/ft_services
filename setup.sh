#! /bin/sh

# clean error.log from previoous setup
rm -f error.log

# сhecking if Docker and Minikube are installed
prog_missing=0
for prog in docker minikube
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
# minikube addons enable dashboard
eval $(minikube docker-env) >/dev/null 2>error.log

# load Kubernetes Balancer and data storage volumes
kubectl apply -f srcs/load_balancer.yaml >/dev/null 2>error.log
printf "✔   \e[1;34mLoad Balancer\e[0m \e[1;32mconfigured\e[0m\n"

# build Docker images and launch them in Kubernetes
for service in nginx wordpress mysql phpmyadmin influxdb grafana ftps
do
	if docker build -t ${service}_alpine ./srcs/$service >/dev/null 2>error.log
	then
		if kubectl apply -f srcs/$service/$service.yaml >/dev/null 2>error.log
		then
			printf "✔   \e[1;34m$service\e[0m \e[1;32mstarted\e[0m\n"
		else
			printf "✔   \e[1;34m$service\e[0m \e[1;31merror\e[0m\n"
		fi
	else
		printf "✔   \e[1;34m$service\e[0m \e[1;31merror\e[0m\n"
	fi
done

# info
printf "\n"
printf "❕  \e[1;35mNGINX\e[0m (\e[1;32msite\e[0m):\t\thttp://192.168.99.10\n"
printf "❕  \e[1;35mNGINX\e[0m (\e[1;33mssh\e[0m):\t\tssh \e[1;34muser\e[0m@192.168.99.10\t\t\t(password: \e[1;34muser\e[0m)\n"
printf "❕  \e[1;35mWordPress\e[0m (\e[1;32msite\e[0m):\t\thttp://192.168.99.20:5050\n"
printf "❕  \e[1;35mWordPress\e[0m (\e[1;31mwp-admin\e[0m):\thttp://192.168.99.20:5050/wp-admin\t(login: \e[1;34madmin\e[0m password: \e[1;34madmin\e[0m)\n"
printf "❕  \e[1;35mphpMyAdmin\e[0m:\t\t\thttp://192.168.99.30:5000\t\t(login: \e[1;34madmin\e[0m password: \e[1;34madmin\e[0m)\n"
printf "❕  \e[1;35mGrafana\e[0m:\t\t\thttp://192.168.99.40:3000\t\t(login: \e[1;34madmin\e[0m password: \e[1;34madmin\e[0m)\n"
printf "❕  \e[1;35mFTP(S)\e[0m:\t\t\tftp://192.168.99.50:21\t\t\t(login: \e[1;34muser\e[0m  password: \e[1;34muser\e[0m )\n"
