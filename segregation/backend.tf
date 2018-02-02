terraform {
  backend "s3" {
    bucket = "malferov.segregation"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
