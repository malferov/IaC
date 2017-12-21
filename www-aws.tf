variable "public_key_path" {}
variable "private_key_path" {}
variable "key_name" {}

resource "aws_security_group" "sg_www_aws" {
  name        = "www"
  description = "Used in the terraform"
#  vpc_id      = "${aws_vpc.default.id}"

# SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
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

resource "aws_instance" "www-aws" {
  ami             = "ami-bf4193c7"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.auth.id}"
  security_groups = ["www"]

  connection {
    user = "ec2-user"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx",
      "sudo service nginx start",
    ]
  }

}

output "ip" {
  value = "${aws_instance.www-aws.public_ip}"
}
