## IaC example project
under construction

### setup multiple environment
Create separate AWS `management` account for storing remote state and creating users.
Create dedicated account per each environment.
Environments correspond to workspaces and are switched by `terraform workspace select _environment_`.
Environment specific resources are encapsulated into module `./environment`.

### route53
In order to deploy environment specific DNS records fill in the following section in `segregation/terraform.tfvars`

```
domain = "_your_subdomain_name_"
api_ip = {
  development = "_development_endpoint_ip_"
  staging     = "_staging_endpoint_ip_"
  production  = "_production_endpoint_ip_"
}
```
