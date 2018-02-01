## IaC example project
under construction

### setup multiple environment
Create separate AWS `management` account for storing remote state and creating users.
Create dedicated account per each environment.
Environments are corresponds to workspaces and switched by `terraform workspace select _environment_name_`.
Environment specific resources are encapsulated into module `./environment`.
