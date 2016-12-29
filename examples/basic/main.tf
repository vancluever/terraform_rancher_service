// The name of the service.
variable "service_name" {
  type    = "string"
  default = "example_service"
}

// The Dockerfile data.
variable "dockerfile_data" {
  type = "string"

  default = <<EOS
FROM ubuntu:16.04
EOS
}

// The image name.
variable "image_name" {
  type    = "string"
  default = ""
}

// example_service provides our sample service.
module "example_service" {
  source          = "../../"
  service_name    = "${var.service_name}"
  dockerfile_data = "${var.dockerfile_data}"
  image_name      = "${var.image_name}"
}

// The write_files section for the user data.
output "write_files_entry" {
  value = "\n${module.example_service.write_files_entry}"
}

// The Docker Compose service in the rancher section of the user data.
output "rancher_service_data" {
  value = "\n${module.example_service.rancher_service_data}"
}
