
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

resource "aws_instance" "www-aws" {
  ami             = "ami-bf4193c7"
  instance_type   = "t2.micro"
  security_groups = ["www"]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }

}

output "ip" {
  value = "${aws_instance.www-aws.public_ip}"
}
