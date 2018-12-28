# Command

## Start minikube

```
$ minikube start
```

## Show dashboard

```
$ minikube dashboard
```

## Create a Deployment

```
$ kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
deployment.apps/hello-node created
$ kubectl get deployments
NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-node   1         1         1            1           43s
$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6f6cbc4649-x6bp4   1/1     Running   0          73s
$ kubectl get events
LAST SEEN   TYPE     REASON                    KIND         MESSAGE
90s         Normal   Scheduled                 Pod          Successfully assigned default/hello-node-6f6cbc4649-x6bp4 to minikube
89s         Normal   Pulling                   Pod          pulling image "gcr.io/hello-minikube-zero-install/hello-node"
64s         Normal   Pulled                    Pod          Successfully pulled image "gcr.io/hello-minikube-zero-install/hello-node"
64s         Normal   Created                   Pod          Created container
64s         Normal   Started                   Pod          Started container
90s         Normal   SuccessfulCreate          ReplicaSet   Created pod: hello-node-6f6cbc4649-x6bp4
90s         Normal   ScalingReplicaSet         Deployment   Scaled up replica set hello-node-6f6cbc4649 to 1
7m5s        Normal   NodeHasSufficientDisk     Node         Node minikube status is now: NodeHasSufficientDisk
7m5s        Normal   NodeHasSufficientMemory   Node         Node minikube status is now: NodeHasSufficientMemory
7m5s        Normal   NodeHasNoDiskPressure     Node         Node minikube status is now: NodeHasNoDiskPressure
7m5s        Normal   NodeHasSufficientPID      Node         Node minikube status is now: NodeHasSufficientPID
6m35s       Normal   Starting                  Node         Starting kube-proxy.
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://localhost:6443
  name: docker-for-desktop-cluster
- cluster:
    certificate-authority: /Users/h0y01c9/.minikube/ca.crt
    server: https://192.168.99.100:8443
  name: minikube
contexts:
- context:
    cluster: docker-for-desktop-cluster
    user: docker-for-desktop
  name: docker-for-desktop
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: docker-for-desktop
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
- name: minikube
  user:
    client-certificate: /Users/h0y01c9/.minikube/client.crt
    client-key: /Users/h0y01c9/.minikube/client.key
```

## Create a service

```
$ kubectl expose deployment hello-node --type=LoadBalancer --port=8080
service/hello-node exposed
$ kubectl get services
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
hello-node   LoadBalancer   10.111.229.4   <pending>     8080:31106/TCP   85s
kubernetes   ClusterIP      10.96.0.1      <none>        443/TCP          12m
$ minikube service hello-node
Opening kubernetes service default/hello-node in default browser...
```
