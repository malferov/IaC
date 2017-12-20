/*
provider "aws" {
  version = "~> 1.6"
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

resource "aws_instance" "tfinst" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
#  ami           = "ami-b374d5a5"
}
*/