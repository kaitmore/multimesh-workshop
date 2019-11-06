#!/bin/bash
clear

read -p "Docker Username: " username
read -sp "Docker Password: " password

echo ""

export DOCKER_USER=$username
export DOCKER_PASSWORD=$password

echo "Starting Minikube..."
minikube start --memory 6144 --cpus 4 --vm-driver=none >/dev/null 2>&1

# Dependencies
echo "Downloading the Greymatter cli..."
curl -u $DOCKER_USER:$DOCKER_PASSWORD https://nexus.production.deciphernow.com/repository/raw-hosted/greymatter/gm-cli/greymatter-v1.0.2.tar.gz --output greymatter-v1.0.2.tar.gz
tar -xzf greymatter-v1.0.2.tar.gz
mv greymatter.linux greymatter
sudo mv greymatter /usr/local/bin
source .profile

echo "Installing Voyager Ingress..."
curl -fsSL https://raw.githubusercontent.com/appscode/voyager/10.0.0/hack/deploy/voyager.sh | bash -s -- --provider=minikube >/dev/null 2>&1

# Installation
echo "Installing Grey Matter..."
kubectl create secret docker-registry docker.secret --docker-server="docker.production.deciphernow.com" --docker-username=$DOCKER_USER --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_USER
kubectl apply -f template.yaml --validate=false >/dev/null 2>&1

while [[ $(kubectl get pods --field-selector=status.phase=Running --output json | jq -j '.items | length') != "8" ]]; do
    clear
    echo "Waiting for pods ($(kubectl get pods --field-selector=status.phase=Running --output json | jq -j '.items | length')/8)"
    kubectl get pods | grep Running
    sleep 10
done

clear

echo "Exposing Edge..."

minikube service voyager-edge >/dev/null 2>&1

echo "The mesh is ready at https://$PUBLIC_IP:30000 !"
