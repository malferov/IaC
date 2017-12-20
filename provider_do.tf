export DO_PAT={YOUR_PERSONAL_ACCESS_TOKEN}
export TF_LOG=1
terraform plan \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$HOME/tf/key/id_rsa.pub" \
  -var "pvt_key=$HOME/tf/key/id_rsa" \
  -var "ssh_fingerprint=e7:42:16:d7:e5:a0:43:29:82:7d:a0:59:cf:9e:92:f7"

variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = "${var.do_token}"
}
