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

### environment deployment
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

### setup deployment environment
You have to install Terraform and `jq` tool.
```
curl -O https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip
unzip ./terraform_0.11.3_linux_amd64.zip && sudo mv ./terraform /usr/local/bin/
sudo yum install jq
```

### setup management environment
Create `management_user` in management account and apply the policy below.
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::malferov.segregation",
                "arn:aws:s3:::malferov.segregation/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "iam:*",
            "Resource": [
#temp           "*",
                "arn:aws:iam::*:policy/*",
                "arn:aws:iam::*:user/*",
                "arn:aws:iam::*:group/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "route53:*",
            "Resource": [
                "arn:aws:route53:::hostedzone/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
#temt           "ec2:*",
                "ec2:DescribeImages",
                "ec2:DescribeImageAttribute",
                "ec2:ModifyImageAttribute"
            ],
            "Resource": "*"
        }
    ]
}
```
