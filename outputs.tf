// module terraform_rancher_service

// The Docker Compose service in the rancher section of the user data.
output "rancher_service_data" {
  value = "${replace(data.template_file.rancher_service_data.rendered, "/\n\\s*~~/", "")}"
}
