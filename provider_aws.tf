variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-west-2"
}

provider "aws" {
  version = "~> 1.6"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}
