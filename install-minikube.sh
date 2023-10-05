#!/bin/bash

# Download and install argo
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install -m 555 minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Start minikube
minikube start