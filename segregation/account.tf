variable "ami_id" {}
variable "env_account" {
  type = "map"
}

module "management" {
  source    = "./management"
  providers = {
    aws = "aws.management"
  }
  ami_id    = "${var.ami_id}"
  account   = "${var.env_account}"
}

module "staging" {
  source = "./environment"
  providers = {
    aws = "aws.staging"
  }
}

module "production" {
  source = "./environment"
  providers = {
    aws = "aws.production"
  }
}
