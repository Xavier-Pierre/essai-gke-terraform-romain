output "project_id" {
  value = "${module.project.project_id}"
}

#output "env" {
#  value = "${var.env[terraform.workspace]}"
#}

output "compute_zone" {
  value = "${module.gke.compute_zone}"
}

output "cluster_name" {
  value = "${module.gke.cluster_name}"
}



