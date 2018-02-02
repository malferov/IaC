variable "environment" {}
variable "domain" {}
variable "api_ip" {
  type = "map"
}
variable "zone" {}

resource "aws_route53_record" "iac-api" {
  provider = "aws.management"
  zone_id  = "${var.zone}"
  name     = "api.${var.environment}.${var.domain}"
  type     = "A"
  ttl      = "60"
  records  = ["${lookup(var.api_ip, var.environment)}"]
}
