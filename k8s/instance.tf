variable "ssh_user" {}
variable "ssh_pub_key" {}
/*
resource "google_compute_instance" "jenkins" {
  name         = "jenkins"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key)}"
  }
}
*/