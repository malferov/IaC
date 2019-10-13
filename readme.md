## IaC example project
[CICD pipeline in AWS](cicd-aws/readme.md)  
[CICD pipeline in GCP](cicd-gcp/readme.md)

The project shows how to deploy sample application to a cloud provider.
The sample application is a restful api web service written in `golang`.
Having machine images tool like `Packer` in your deployment pipeline gives you even more flexibility.
It gives you an option to run your application almost everywhere: starting from on-premises enterprise solutions end up with cloud-based.
The main tool is `Terraform` taking over control of `AWS` cloud provider infrastructure.
The deployment pipeline is fully automated.
One of the main goal is provide an ability for collaborative work.
Taking into account the nature of any application life cycle is a teamwork, isolated environments are essential.
This is infrastructure as code. It benefits us with source control and code review of our infrastructure.

### setup multiple environment
Create separate AWS `management` account for storing remote state and managing common components.
Create dedicated account per each environment.
Environments correspond to workspaces and are switched by `terraform workspace select _environment_`.
Environment specific resources are encapsulated into module `./environment`.

### route53
In order to deploy environment specific DNS records fill in the following section in `segregation/terraform.tfvars`
```
domain = "_subdomain_name_"
```
Environments are deployed under subdomain name above. Application endpoint is `https://api._environment_name_._subdomain_name_/`

### setup deployment environment
You have to install Terraform and `jq` tool.
```
curl -O https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip
unzip ./terraform_0.11.3_linux_amd64.zip && sudo mv ./terraform /usr/local/bin/
sudo yum install jq
```

### setup management environment
It is necessary to deploy management environment first.
Manually create `management_user` in management account and apply the policy below.
<details><summary>IAM policy for management user</summary>

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::bucket_name"
        },
        {
            "Effect": "Allow",
            "Action": ["s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::bucket_name/terraform.tfstate"
        },
        {
            "Effect": "Allow",
            "Action": "iam:*",
            "Resource": [
                "arn:aws:iam::*:policy/*",
                "arn:aws:iam::*:user/*",
                "arn:aws:iam::*:group/*",
                "arn:aws:iam::*:role/*",
                "arn:aws:iam::*:instance-profile/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:CreateHostedZone",
                "route53:DeleteHostedZone",
                "route53:ListHostedZones",
                "route53:GetHostedZone"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:*",
            "Resource": [
                "arn:aws:route53:::hostedzone/*",
                "arn:aws:route53:::change/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "acm:ImportCertificate",
                "acm:DescribeCertificate",
                "acm:ListTagsForCertificate",
                "acm:DeleteCertificate"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:CreateCluster",
                "eks:DeleteCluster",
                "autoscaling:*",
                "elasticloadbalancing:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ecs:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ecr:*",
            "Resource": "*"
        }
    ]
}
```

</details>

After creation management user and applying policy above, create security credentials for that user.
Create new key pair in section `access keys` and copy key values to the `segregation/terraform.tfvars`.

Manually create `environment_root_user` in every environment account and apply the policy below.
<details><summary>IAM policy for environment root user</summary>

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:*"
            ],
            "Resource": [
                "arn:aws:iam::*:policy/*",
                "arn:aws:iam::*:user/*",
                "arn:aws:iam::*:group/*",
                "arn:aws:iam::*:role/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*"
            ],
            "Resource": "*"
        }
    ]
}
```

</details>

After creation environment root user in every environment account and applying policy above, create security credentials for those users.
Create new key pair in section `access keys` and copy key values to the `segregation/terraform.tfvars`.

When you have ready credentials for all accounts then deploy management environment.
```
cd segregation
terraform init
terraform plan
terraform apply
```
Initiate environment variables invoking `artifact_export.sh`.

### deployment of new environment
From the environment working directory create new workspace and deploy new environment.
```
terraform workspace new _environment_
terraform apply -auto-approve
```

### application image and packer
In order to run application EC2 service of AWS is used. Custom AMI image is created by `Packer` and provisioned with sample api web service.
At first build the golang application:
```
cd app
make deps
make build
```
then create and register new AMI image `cd ../packer; make`,
and update access policy to the new image `cd ../segregation; terraform apply`,
and finally update current environment with new version of application `cd ..; terraform apply`.
