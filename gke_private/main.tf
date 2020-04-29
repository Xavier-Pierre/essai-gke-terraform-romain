provider "google" {
  version = "~> 2.11"
  project = "${var.project_id}"
  region  = "${var.region}"
}

provider "random" {}

resource "random_id" "gke_master_pwd" {
  byte_length = 8
  prefix      = "?${var.env}-"
}

resource "google_container_cluster" "primary" {
  lifecycle {
    # On ignore les changements sur les versions des versions des nodes/master
    ignore_changes = ["min_master_version", "node_version"]
  }

  #name                     = "gke-${var.env}-${var.project_name}-cluster-private"
  name                     = "cluster-essai-romain"
  location                 = "${var.gke_region}-c"
  remove_default_node_pool = true
  initial_node_count       = "${var.gke_num_nodes}"
  enable_legacy_abac       = false
  network                  = "${var.vpc_name}"
  subnetwork               = "${var.subnet_name}"

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
      display_name = "Public"
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-ip-range"
    #cluster_secondary_range_name  = "${var.pods_cidr_range_name}"
    services_secondary_range_name = "services-ip-range"
    #services_secondary_range_name = "${var.services_cidr_range_name}"
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "${var.master_cidr_range}"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  master_auth {
    username = "${var.gke_master_user}"
    password = "${random_id.gke_master_pwd.hex}"

    client_certificate_config {
      issue_client_certificate = "${var.issue_client_certificate}"
    }
  }

  resource_labels {
    env     = "${var.env}"
    project = "${var.project_name}"
    app     = "gke"
  }

  min_master_version = "${var.min_master_version}"
  node_version       = "${var.node_version}"
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name               = "gke-${var.env}-${var.project_name}-node-pool"
  location           = "${var.gke_region}-c"
  cluster            = "${google_container_cluster.primary.name}"
  initial_node_count = "${var.gke_num_nodes}"

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/trace.append",
    ]

    # preemptible = true
    metadata {
      disable-legacy-endpoints = "true"
    }

    labels {
      env     = "${var.env}"
      project = "${var.project_name}"
      app     = "node_pool"
    }

    disk_size_gb = "${var.gke_node_machine_disk_size}"
    machine_type = "${var.gke_node_machine_type}"
    tags         = ["gke-node"]
  }
}
