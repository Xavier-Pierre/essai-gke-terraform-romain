provider "google" {
  version = "~> 2.11"
  region  = "${var.region}"
}

module "project" {
  source        = "./project"
  project_name  = "${var.project_name}"
  #env           = "${var.env[terraform.workspace]}"
  env           = "${var.env}"
  activate_apis = "${var.activate_apis}"
}

module "vpc" {
  source     = "./vpc"
  region     = "${var.region}"
  project_id = "${module.project.project_id}"
}

module "subnet" {
  source      = "./subnet"
  region      = "${var.region}"
  project_id  = "${module.project.project_id}"
  vpc_name    = "${module.vpc.vpc_name}"
  #subnet_cidr = "${var.subnet_cidr[terraform.workspace]}"
  subnet_cidr = "${var.subnet_cidr}"
  #env         = "${var.env[terraform.workspace]}"
  env         = "${var.env}"
  name        = "${module.subnet.subnet_name}"
  #name        = "${module.}"
  name        = "${var.subnet_name}"

 secondary_ip_ranges = [
    {
      range_name    = "gke-pods-subnet"
      ip_cidr_range = "${var.secondary_ip_cidr_gke_pods}"
    },
    {
      range_name    = "gke-svc-subnet"
      ip_cidr_range = "${var.secondary_ip_cidr_gke_svc}"
    },
  ]
}

module "subnet_private" {
  source      = "./subnet"
  region      = "${var.region}"
  project_id  = "${module.project.project_id}"
  vpc_name    = "${module.vpc.vpc_name}"
#  subnet_cidr = "${var.subnet_cidr_private[terraform.workspace]}"
#  env         = "${var.env[terraform.workspace]}"
#  name        = "${var.env[terraform.workspace]}-gke-private"
  subnet_cidr = "${var.subnet_cidr_private}"
  env         = "${var.env}"
  name        = "${var.env}-gke-private"

  google_private_access = true

  secondary_ip_ranges = [
    {
      range_name    = "gke-pods-private"
      ip_cidr_range = "${var.secondary_ip_cidr_gke_pods}"
    },
    {
      range_name    = "gke-svc-private"
      ip_cidr_range = "${var.secondary_ip_cidr_gke_svc}"
    },
  ]
}


#module "static_ip" {
#  source     = "../modules/backend/static_ip"
#  region     = "${var.region}"
#  project_id = "${module.project.project_id}"
#}

module "gke" {
  source                     = "./gke_private"
  region                     = "${var.region}"
  project_name               = "${var.project_name}"
  project_id                 = "${module.project.project_id}"
  min_master_version         = "${var.min_master_version}"
  #env                        = "${var.env[terraform.workspace]}"
  env                        = "${var.env}"
  node_version               = "${var.node_version}"
  #gke_num_nodes              = "${var.gke_num_nodes[terraform.workspace]}"
  gke_num_nodes              = 4
  vpc_name                   = "${module.vpc.vpc_name}"
  subnet_name                = "${var.subnet_name}"
  #subnet_name                = "${module.subnet.subnet_name}"
  #subnet_name                = "${module.subnet_private.subnet_name}"
  #gke_node_machine_type      = "${var.gke_node_machine_type[terraform.workspace]}"
  #gke_node_machine_disk_size = "${var.gke_node_machine_disk_size[terraform.workspace]}"
  gke_node_machine_type      = "n1-standard-1"
  gke_node_machine_disk_size = "50"
  master_cidr_range          = "${var.gke_master_cidr_range}"
  pods_cidr_range_name       = "gke-pods-subnet"
  services_cidr_range_name   = "gke-svc-subnet"
}
