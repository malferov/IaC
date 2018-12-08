# terraform.tfvars
```
access_key    = ""
secret_key    = ""
region        = ""
instance_type = "t2.micro"
public_key    = ".key/user.pub"
private_key   = ".key/user.pem"
docker_id     = ""
scale_factor  = 2
db_user       = "username"
db_pass       = "password"
white_listed  = ["0.0.0.0/0"] # list your trusted nets
app_repo      = "https://github.com/demo_flask.git"
```

# .key
- create ssh key `ssh-keygen -f user.pem -N""`
- rename public to `.pub`
- place both in `.key` subdir

# subscribe aws account to centos images
https://aws.amazon.com/marketplace/pp?sku=aw0evgkw8e5c1q413zgy5pjce

# build server
```
terraform init
terraform plan -target=aws_instance.build -out=tfplan
terraform apply tfplan
```
- login to build server http://{terraform.output.build}:8080/
- create aws and infra repo credentials (Jenkins -> Credentials -> Global credentials -> Add Credentials)
  * access_key { type = secret text }
  * secret_key { type = secret text }
  * infra-repo-cred { type = username with password } (please use github username and personal access token for password)
  * docker_id   { type = secret text }
  * docker_pass { type = secret text }
- create new `pipeline` project and specify `Jenkinsfile`
- fill in `scale_factor`

# deployment
```
for the first time build please use empty Jenkinsfile.init pipeline
due to https://issues.jenkins-ci.org/browse/JENKINS-41929
set Jenkinsfile for pipeline
run jenkins build with parameters
```

# test
- app url `http://{terraform.output.elb}`
- build server `http://{terraform.output.build}:8080`
- kibana `http://{terraform.output.build}:5601`
