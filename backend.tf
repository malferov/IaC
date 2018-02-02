terraform {
  backend "s3" {
    bucket = "malferov.environment"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
