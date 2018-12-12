variable "app_repo" {}
variable "size" {}
variable "public_key" {
  #  default = "/dev/null"
}

variable "private_key" {
  #  default = "/dev/null"
}

locals {
  yum   = "sudo yum -y -d 1 install"
  image = "centos-7"
  user  = "centos"
}

resource "google_compute_instance" "build" {
  name         = "build"
  machine_type = "${var.size}"

  boot_disk {
    initialize_params {
      image = "${local.image}"
    }
  }

  network_interface {
    network       = "${data.google_compute_network.net.name}"
    access_config = {}
  }

  metadata {
    sshKeys = "${local.user}:${file(var.public_key)}"
  }

  connection {
    user        = "${local.user}"
    private_key = "${file(var.private_key)}"
  }

  provisioner "file" {
    source      = "jenkins"
    destination = "~"
  }
  provisioner "remote-exec" {
    inline = [
      "${local.yum} docker git mc",
      "sudo systemctl start docker",
      "sudo git clone ${var.app_repo} && cd iac/k8s/jenkins",
      "sudo docker build -t jenkins .",
      "sudo chmod 777 /var/run/docker.sock",
      "sudo docker run --name jenkins -d -p 8080:8080 -v /var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins",
    ]
  }
}

output "build" {
  value = "${google_compute_instance.build.network_interface.0.access_config.0.assigned_nat_ip}"
}
