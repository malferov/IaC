variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_key_fp" {}

resource "digitalocean_droplet" "www-1" {
  image = "centos-7-x64"
  name = "www-1"
  region = "ams3"
  size = "512mb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_key_fp}"
  ]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "1m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo yum -y install nginx"
    ]
  }

}
