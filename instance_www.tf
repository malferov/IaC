variable "public_key_path" {}
variable "private_key_path" {}
variable "key_name" {}
variable "ami_id" {}

resource "aws_security_group" "sg_www_aws" {
  name        = "www"
  description = "Used in the terraform"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "www" {
  count           = 1
  ami             = "${var.ami_id}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.auth.id}"
  security_groups = ["www"]
}

output "ip" {
  value = "${aws_instance.www.*.public_ip}"
}
