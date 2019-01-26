## Setup deployment workstation
In order to deploy infrastructure components you must setup deployment environment (workstation) where you need to clone the repo and to install Terraform. The repo does not consist of sensitive variable values. Please fill in the values to the terraform.tfvars file (see below).

- clone repo `git clone repo`
- download terraform https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip please note tested on CentOS 7.5
- unzip and install terraform `unzip ./terraform_0.11.7_linux_amd64.zip && sudo mv ./terraform /usr/local/bin/`
- setup terraform variables `cd terraform && touch terraform.tfvars`
- add to `terraform.tfvars` the following content
```
token            = "digitalocean api token"
private_key_path = ".key/username.pem" # private key of one of the users for provisioning
# public keys needs to be placed to .key dir and have `username.pub` filename pattern
region           = "droplet region"
size             = "2gb"
domain           = "domain name"
couchdb_host     = "couchdb hostname"
couchdb_port     = "couchdb port"
couchdb_user     = "couchdb username"
couchdb_pass     = "couchdb password"
access_key       = "aws accesss key"
secret_key       = "aws secret key"
region_aws       = "aws region"
email            = "admin@c3s"
letsencrypt_url  = "https://acme-v02.api.letsencrypt.org/directory" # run `terraform apply` to renew the cert. 7 days before expiration or later
```
- generate key pair `mkdir .key && cd .key && ssh-keygen -f c3s.pem`
- terraform initializing `cd .. && terraform init`

## Infrastructure deployment
From your deployment environment please run the commands below.

- review infrastructure changes `terraform plan`
- deploy to the cloud provider `terraform apply`, type in `yes` for confirmation

## CircleCI
Setup environment variable `TEST_SERVER` and upload ssh private key for provisioning `SSH Permissions - Add SSH Key`
