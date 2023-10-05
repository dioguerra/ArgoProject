## Installing Argo and managing applications in our clusters

We will use an Argo installation to control our deployed software.
In this case we are deploying a Argo Workflows application.

Argo allows to manage multiple software in multiple kubernetes clusters.
This last point, in turn, allows us to control applications deployments
across clusters and cluster providers.

With access to a control cluster (in this case the local minikube cluster)
created previously. Let's deploy our argo controller application:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

We will also be needing argocd client so we can interact with argocd.
Install this following the [documentation](https://argo-cd.readthedocs.io/en/stable/cli_installation/) upstream or by running the commands bellow:

```bash
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
```

### Interacting with Argo using the browser

You can interact with your Argo deployment via browser by running the command bellow.
Credentials for admin access are also provided.
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
echo "User: admin"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -ojsonpath='{.data.password}' | base64 -d)"
```

> **_NOTE:_**  For the porposes of this tutorial we will not setup users
and will instead use the admin account. Ideally a system backed by a
centralized authentication server should be use for ease of management, integration and maintenance.

## Setting up our application:

Our application(s) should be setup in the services folder where argocd
will keep track of the current state defined for the application.
As such, any new releases we wich to make should be pushed to the git
repository that we are tracking (https://github.com/dioguerra/ArgoProject)

Deploy the controller application by running:

```
kubectl apply -f main.yaml -n argocd
```

In the last step, you need to add the repository to the tracked argocd repositoies.
Do this by accessing `https://localhost:8080` and then navigating into
```
Settings -> Repositories -> Connect Repo

Connection method: Via https
Name: ArgoProject
Project: default
Repository URL: https://github.com/dioguerra/ArgoProject.git
```

<!-- helm repo add argo https://argoproj.github.io/argo-helm
helm repo update argo
helm install argocd argo/argo-cd -n argocd --version 5.46.7 -->