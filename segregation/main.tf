variable "ami_id" {}
variable "domain" {}
variable "backet" {}
variable "mgt_account" {}
variable "env_account" {type = "map"}
variable "address"     {type = "map"}
variable "itype" {}

module "management" {
  source    = "./management"
  providers = {
    aws = "aws.management"
  }
  ami_id  = "${var.ami_id}"
  account = "${var.env_account}"
  domain  = "${var.domain}"
  backet  = "${var.backet}"
}

module "staging" {
  source      = "./environment"
  providers   = {
    aws = "aws.staging"
  }
  environment = "staging"
  domain      = "${var.domain}"
  address     = "${var.address}"
  zone        = "${module.management.zone}"
  account     = "${var.mgt_account}"
  region      = "${var.region}"
  itype       = "${var.itype}"
}

module "production" {
  source      = "./environment"
  providers   = {
    aws = "aws.production"
  }
  environment = "production"
  domain      = "${var.domain}"
  address     = "${var.address}"
  zone        = "${module.management.zone}"
  account     = "${var.mgt_account}"
  region      = "${var.region}"
  itype       = "${var.itype}"
}
