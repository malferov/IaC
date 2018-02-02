variable "environment" {}
variable "domain" {}
variable "address" {
  type = "map"
}
variable "zone" {}

resource "aws_route53_record" "iac-api" {
  provider = "aws.management"
  zone_id  = "${var.zone}"
  name     = "api.${var.environment}.${var.domain}"
  type     = "A"
  ttl      = "60"
  records  = ["${lookup(var.address, var.environment)}"]
}
