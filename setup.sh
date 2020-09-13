#! /bin/sh

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
				--cpus 2 --disk-size=5000mb --memory=2048mb
minikube addons enable metallb
# minikube addons enable metrics-server
eval $(minikube docker-env) > /dev/null

# load Kubernetes Balancer and data storage volumes
kubectl apply -f srcs/load_balancer.yaml > /dev/null
printf "\e[1;34mLoad Balancer\e[0m \e[1;32mconfigured\e[0m\n"
kubectl apply -f srcs/volumes.yaml > /dev/null
printf "\e[1;34mPersistent volumes\e[0m \e[1;32mcreated\e[0m\n"

# build Docker images and launch them in Kubernetes
for service in wordpress mysql phpmyadmin
do
	docker build -t ${service}_alpine ./srcs/$service > /dev/null
	kubectl apply -f srcs/$service.yaml > /dev/null
	printf "\e[1;34m$service\e[0m \e[1;32mstarted\e[0m\n"
done

# info
printf "\e[1;35mNGINX\e[0m:\t\t\thttp://192.168.99.1\n"
printf "\e[1;35mWordPress\e[0m (\e[1;32msite\e[0m):\thttp://192.168.99.2:5050\n"
printf "\e[1;35mWordPress\e[0m (\e[1;31mwp-admin\e[0m):\thttp://192.168.99.2:5050/wp-admin\t(login: \e[1;34madmin\e[0m password: \e[1;34madmin\e[0m)\n"
printf "\e[1;35mphpMyAdmin:\e[0m:\t\thttp://192.168.99.3:5000\t\t(login: \e[1;34madmin\e[0m password: \e[1;34madmin\e[0m)\n"
