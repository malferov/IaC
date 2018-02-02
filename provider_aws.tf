variable "access_key" {
  type = "map"
}
variable "secret_key" {
  type = "map"
}
variable "region" {}

provider "aws" {
  access_key = "${var.access_key[terraform.workspace]}"
  secret_key = "${var.secret_key[terraform.workspace]}"
  region     = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "malferov.environment"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
