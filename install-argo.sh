#!/bin/bash

# Deploy Argo application
cd argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update argo
helm dependency update

kubectl create ns argocd
helm --namespace argocd template -f values.yaml "argocd" . \
        | yq e 'select(.kind == "CustomResourceDefinition")' - \
        > generated.yaml
kubectl apply -f generated.yaml -n argocd && rm generated.yaml
helm template argocd . -n argocd --values values.yaml --version 5.46.7 | kubectl apply -f -

sleep 60

# Expose Argocd application to local browser
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
echo "Login to your argocd controller by visiting https://localhost:8080"
echo "You should use credentials admin:$(kubectl -n argocd get secret argocd-initial-admin-secret -ojsonpath='{.data.password}' | base64 -d)"
