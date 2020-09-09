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

# build Docker images
# images=(ftps grafana influxdb mysql nginx phpMyAdmin telegraf wordpress)
# for image in ftps grafana influxdb mysql nginx phpMyAdmin telegraf wordpress
# for image in "${images[@]}"
# for image in nginx
# do
#     echo $image
#     docker build -t $image ./srcs/$image
# done

# start minikube
# minikube start --vm-driver=virtualbox \
	# --cpus 2 --disk-size=2048mb --memory=2048mb
# minikube addons enable metallb
# minikube addons enable metrics-server
