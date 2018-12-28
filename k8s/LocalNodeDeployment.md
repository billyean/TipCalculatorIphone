## Create image in dockerhut

```
$ docker build .
$ docker tag 70acafb09930 billyean/node:1.0.0
$ docker login --username=billyean
$ docker push billyean/node
```
## Deploy node application

```
$ kubectl apply -f  node-deployment.yaml
deployment.apps/node-deployment created
$ kubectl expose deployment node-deployment --type=NodePort
service/node-deployment exposed
$ minikube service node-deployment --url
http://192.168.99.100:30979
```
