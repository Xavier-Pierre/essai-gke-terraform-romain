# GKE outputs
output "endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
  description = "Endpoint for accessing the master node"
}

output "cluster_username" {
  value = "${google_container_cluster.primary.master_auth.0.username}"
}

output "cluster_master_pwd" {
  value = "${google_container_cluster.primary.master_auth.0.password}"
}

output "cluster_name" {
  value = "${google_container_cluster.primary.name}"
}

output "compute_zone" {
  value = "${google_container_cluster.primary.zone}"
}
