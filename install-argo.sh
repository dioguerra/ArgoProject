#!/bin/bash

# Deploy Argo application
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Download and install argocli
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Expose Argocd application to local browser
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
echo "Login to your argocd controller by visiting https://localhost:8080"
echo "You should use credentials admin:$(kubectl -n argocd get secret argocd-initial-admin-secret -ojsonpath='{.data.password}' | base64 -d)"
