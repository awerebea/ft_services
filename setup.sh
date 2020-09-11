#! /bin/bash

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
kubectl apply -f srcs/balancer.yaml
kubectl apply -f srcs/volumes.yaml

# build Docker images and launch them in Kubernetes
services=(nginx wordpress mysql)
for service in "${services[@]}"
do
	docker build -t $service:ft_services ./srcs/$service > /dev/null
	kubectl apply -f srcs/$service.yaml
done
