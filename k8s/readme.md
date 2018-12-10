enable Kubernetes Engine API by visiting service console

kubectl config set-cluster cicd --server=https://35.184.214.121 --insecure-skip-tls-verify
kubectl config get-clusters
kubectl config set-credentials admin --username=admin --password=password
kubectl config set-context cicd --cluster=cicd --user=admin
kubectl config use-context cicd

kubectl create deployment app --image=malferov/app:3
kubectl expose deployment app --type=LoadBalancer --port=5000
kubectl delete service app
kubectl delete deployment app
