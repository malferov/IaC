## IaC example project
under construction

### setup multiple environment
Create separate AWS `management` account for storing remote state and creating users.
Create dedicated account per each environment.
Environments correspond to workspaces and are switched by `terraform workspace select _environment_`.
Environment specific resources are encapsulated into module `./environment`.
