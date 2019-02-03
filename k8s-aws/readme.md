## deployment
```
terraform apply -target=local_file.service
kubectl apply -f manifest/app.yaml
kubectl apply -f manifest/service.yaml
./hostname.sh
terraform apply
```
