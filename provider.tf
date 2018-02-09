variable "access_key"  {type = "map"}
variable "secret_key"  {type = "map"}
variable "env_account" {type = "map"}
variable "region" {}

provider "aws" {
  access_key  = "${var.access_key[terraform.workspace]}"
  secret_key  = "${var.secret_key[terraform.workspace]}"
  region      = "${var.region}"
  assume_role = {
    role_arn = "arn:aws:iam::${var.env_account[terraform.workspace]}:role/environment_role"
  }
}
