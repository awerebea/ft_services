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
kubectl apply -f srcs/balancer.yaml > /dev/null
printf "\e[1;34mBalancer\e[0m \e[1;32mconfigured\e[0m\n"
kubectl apply -f srcs/volumes.yaml > /dev/null
printf "\e[1;34mPersistent volumes\e[0m \e[1;32mcreated\e[0m\n"

# build Docker images and launch them in Kubernetes
for service in nginx wordpress mysql
do
	docker build -t ${service}_img ./srcs/$service > /dev/null
	kubectl apply -f srcs/$service.yaml > /dev/null
	printf "\e[1;34m$service\e[0m \e[1;32mstarted\e[0m\n"
done
