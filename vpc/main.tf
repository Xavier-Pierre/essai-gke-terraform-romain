provider "google" {
  version = "~> 2.11"
  project = "${var.project_id}"
  region = "${var.region}"
}

# Create VPC
resource "google_compute_network" "vpc" {
  name = "vpc-essai-romain"
  #name = "${terraform.workspace}-vpc"
  auto_create_subnetworks = "true"
  #auto_create_subnetworks = "true"
}
