
resource "aws_instance" "www-2" {
  ami           = "ami-bf4193c7"
  instance_type = "t2.micro"
}
