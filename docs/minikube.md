## Requisites

To test the deployment on a local machine, deploy minikube by consulting the
[documentation](https://minikube.sigs.k8s.io/docs/start/) upstream or follow the instructions bellow if working on a linux
system: 

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install -m 555 minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
```

After installing minikube, start up cluster by following the commands below:

```bash
minikube start
```

And finally check that all components of kubernetes are up and running:
```bash
kubectl get po -A
NAMESPACE     NAME                               READY   STATUS        RESTARTS         AGE
kube-system   coredns-5d78c9869d-q4tjf           1/1     Running       2 (8m35s ago)    34d
kube-system   etcd-minikube                      1/1     Running       1 (34d ago)      34d
kube-system   kube-apiserver-minikube            1/1     Running       1 (9m10s ago)    34d
kube-system   kube-controller-manager-minikube   1/1     Running       1 (34d ago)      34d
kube-system   kube-proxy-dxwtt                   1/1     Running       1 (34d ago)      34d
kube-system   kube-scheduler-minikube            1/1     Running       1 (34d ago)      34d
kube-system   storage-provisioner                1/1     Running       3 (8m18s ago)    34d
```