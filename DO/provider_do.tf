#export TF_LOG=1

variable "do_token" {}

provider "digitalocean" {
  version = "~> 0.1"
  token = "${var.do_token}"
}
