variable "domain" {}
variable "zone" {}

resource "aws_route53_record" "iac-api" {
  provider = "aws.management"
  zone_id  = "${var.zone}"
  name     = "api.${terraform.workspace}.${var.domain}"
  type     = "A"
  ttl      = "60"
  records  = ["${aws_instance.api.public_ip}"]
}
