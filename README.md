# ft_services
21-School (Ecole42) 'ft_services' project. Score 100/100.

## Description
This is a System Administration and Networking project. The project consists of setting up an infrastructure of different services. It is set up a multi-service cluster, using Kubernetes.

## Dependencies
To test this project, you need to have [Docker](https://www.docker.com/), [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) and [VirtualBox](https://www.virtualbox.org/) installed on your system.

## Usage
To build all Docker containers and run them within Kubernetes run `./setup.sh` from root of this repository.

If errors occur during build and run :disappointed:, you can check the `error.log` file  to see what went wrong. If it's not there, then everything went as it should :wink:

Once the build is complete, you will see a note in the terminal with the IP addresses of the services and credentials to log into them. 

To launch Kubernetes dashboard run `minikube dashboard`.

To clean up the created environment and free up space on your hard disk, run `minikube delete`.
