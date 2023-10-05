## Welcome to this ArgoCD deployer demo application

## Roadmap
  * Install required applications
  * Install/configure kubernetes cluster to use as bootstrap environment
  * Launch application controller and main application tracker
  * Profit

### Requisites
This guide assumes that you currently have installed in your system kubectl.
If not, unstall it following the upstream [documentation](https://kubernetes.io/docs/tasks/tools/) or the command below:
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
```

Validate the application is installed with:
```bash
kubectl version --client
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
it's apps. Follow the documentation provided in this repo under [docs/argocd.md](https://github.com/dioguerra/ArgoProject/blob/main/docs/argocd.md)



### TODO
* Make argocd manage iitself (update docs too)
  * This will allow to add clusters programatically using argocd/values.yaml ClusterCredentials
  * extra cluster installations for workflows (in this case) will be added to services/argo-workflows.yaml `spec.generators[].list.elements[]`