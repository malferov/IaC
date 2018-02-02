variable "ami_id" {}
variable "env_account" {
  type = "map"
}
variable "domain" {}
variable "api_ip" {
  type = "map"
}
module "management" {
  source    = "./management"
  providers = {
    aws = "aws.management"
  }
  ami_id    = "${var.ami_id}"
  account   = "${var.env_account}"
  domain    = "${var.domain}"
}

module "staging" {
  source      = "./environment"
  providers   = {
    aws = "aws.staging"
  }
  environment = "staging"
  domain      = "${var.domain}"
  api_ip      = "${var.api_ip}"
  zone        = "${module.management.zone}"
}

module "production" {
  source      = "./environment"
  providers   = {
    aws = "aws.production"
  }
  environment = "production"
  domain      = "${var.domain}"
  api_ip      = "${var.api_ip}"
  zone        = "${module.management.zone}"
}
