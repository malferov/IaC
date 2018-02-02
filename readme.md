## IaC example project
under construction

### setup multiple environment
Create separate AWS `management` account for storing remote state and managing common components.
Create dedicated account per each environment.
Environments correspond to workspaces and are switched by `terraform workspace select _environment_`.
Environment specific resources are encapsulated into module `./environment`.

### route53
In order to deploy environment specific DNS records fill in the following section in `segregation/terraform.tfvars`
```
domain = "_your_subdomain_name_"
```

### deployment
It is necessary to deploy management environment first.
```
cd segregation
terraform init
terraform plan
terraform apply
```
Then switch back to the environment working directory. Create new workspace and deploy new environment.
```
cd ..
terraform workspace new _environment_
terraform apply -auto-approve
./facts_update.sh
```
Finally update DNS records from the management account invoking `cd segregation && terraform apply -auto-approve`.
