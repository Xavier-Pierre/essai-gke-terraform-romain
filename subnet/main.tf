locals {
  subnet_name = "subnet-essai-romain"
  #subnet_name = "${var.name == "" ? "${var.env}-subnet" : "${var.name}"}"
}

provider "google" {
  version = "~> 2.11"
  project = "${var.project_id}"
  region = "${var.region}"
}

# Create Subnet
resource "google_compute_subnetwork" "subnet" {
  name = "${local.subnet_name}"
  ip_cidr_range = "${var.subnet_cidr}"
  network = "${var.vpc_name}"
  region = "${var.subnet_region}"

  private_ip_google_access = "${var.google_private_access}"
  secondary_ip_range       = "${var.secondary_ip_ranges}"
}