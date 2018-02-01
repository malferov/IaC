
module "management" {
  source = "./environment"
  providers = {
    aws = "aws.management"
  }
}

module "staging" {
  source = "./environment"
  providers = {
    aws = "aws.staging"
  }
}

module "production" {
  source = "./environment"
  providers = {
    aws = "aws.production"
  }
}
