# Project creation output
output "project_id" {
  value = "${google_project.project.project_id}"
}

output "service" {
  value = "${google_project_service.project_services.*.service}"
}

output "project_number" {
  value = "${google_project.project.number}"  
}
