## Installing Argo and managing applications in our clusters

We will use an Argo installation to control our deployed software.
In this case we are deploying a Argo Workflows application.

Argo allows to manage multiple software in multiple kubernetes clusters.
This last point, in turn, allows us to control applications deployments
across clusters and cluster providers.

With access to a control cluster (in this case the local minikube cluster)
created previously. Let's deploy our argo controller application:

```bash
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
```

Our application(s) should be setup in the services folder where argocd
will keep track of the current state defined for the various tracked applications.
As such, any new releases we wish to make should be pushed to the git
repository that we are tracking (https://github.com/dioguerra/ArgoProject)

### Interacting with Argo using the browser

You can interact with your Argo deployment via browser by running the command bellow.
Credentials for admin access are also provided.
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
echo "User: admin"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -ojsonpath='{.data.password}' | base64 -d)"
```

> **_NOTE:_**  For the purposes of this tutorial we will not setup users
and will instead use the admin account. Ideally a system backed by a
centralized authentication server should be use for ease of management, integration and maintenance.