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
