variable "project" {}
variable "region" {}
variable "zone" {}

provider "google" {
  credentials = "${file(".key/account.json")}"

  #  project     = "mimetic-scion-225018"
  project = "${var.project}"

  #  region      = "us-central1"
  region = "${var.region}"
  zone   = "${var.zone}"
}
