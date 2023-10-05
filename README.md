## Welcome to this ArgoCD deployer demo application
Executing scripts indicated in this tutorial will require you to have them
available to you. Download this repo to your local computer:
```
cd /tmp
git clone https://github.com/dioguerra/ArgoProject.git
cd ArgoProject
```

## Roadmap
  * Install dependencies
  * Install/configure kubernetes cluster to use as bootstrap environment
  * Launch application controller and main application tracker
  * Profit

### Requisites
This guide assumes that you currently have installed in your system kubectl.
If not, install it following the upstream [documentation](https://kubernetes.io/docs/tasks/tools/) or the command below:
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
```

Validate the application is installed with:
```bash
kubectl version --client
```

We will also use helm to generate the kubernetes manifests. Check the upstream
[documentation](https://helm.sh/docs/intro/install/) or follow the command below:
```bash
HELM_LATEST=$(curl -s https://github.com/helm/helm/releases | grep "Download Helm" | grep -oE "v[0-9]+\.[0-9]+\.[0-9]+\." | head -n1 | rev | cut -c2- | rev)
curl https://get.helm.sh/helm-${HELM_LATEST}-linux-amd64.tar.gz -o helm-latest.tar.gz
tar zxvf helm-latest.tar.gz
sudo install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm
rm -rf helm-latest.tar.gz linux-amd64
```

You will require a bootstraping kubernetes cluster. Create one by following the 
minikube [documentation](https://github.com/dioguerra/ArgoProject/blob/main/docs/minikube.md) provided in this repo.
Alternatibely you can run the command:
```bash
./install-minikube.sh
```

### Run Application Controller
We will use ArgoCD as our application(s) controller. After validating that the
cluster is up and running `kubectl get po -A`, launch and install ArgoCD and
it's apps. Follow the documentation provided in this repo under [docs/argocd.md](https://github.com/dioguerra/ArgoProject/blob/main/docs/argocd.md).
Alternatively run the following command:
```bash
./install-argo.sh
```

### Extend applications to other clusters
To launch the argo-workflows application on other clusters in the cloud,
the following steps must be done:
* Add the cluster configuration parameters to the tracked clusters
in the `argocd/values.yaml` file under `clusterCredentials`.
* Add the cluster name used in the added cluster above to the
`services/argo-workflows.yaml` generators list, just below `- cluster: in-cluster`

> **_NOTE:_**  Please note that sensitive information should not be added to the
repository itself and instead a secret provider should be used (like Hashicorp/Vault).

### Other Thoughs
I am not sure It was intended to add a way for me to deploy a cluster in
a cloud provider, but if this is the intention we would use OpenTofu for this purpose
Documentation is provided [upstream](https://developer.hashicorp.com/terraform/tutorials/kubernetes) on how this can be done.
In this case I assume that target cluster access is provided.