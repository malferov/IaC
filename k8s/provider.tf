variable "project" {}
variable "region" {}
variable "zone" {}

provider "google" {
  credentials = "${file(".key/account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

/*
provider "kubernetes" {
  host = "${google_container_cluster.primary.endpoint}"
  client_certificate     = "${google_container_cluster.primary.master_auth.0.client_certificate}"
  client_key             = "${google_container_cluster.primary.master_auth.0.client_key}"
  cluster_ca_certificate = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
*/
provider "kubernetes" {
  host     = "${google_container_cluster.primary.endpoint}"
  username = "${google_container_cluster.primary.master_auth.0.username}"
  password = "${google_container_cluster.primary.master_auth.0.password}"
}
