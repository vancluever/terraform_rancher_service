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
  default = "example_image"
}

// The capabilities for the service.
variable "capabilities" {
  type = "list"

  default = [
    "CAP_1",
    "CAP_2",
  ]
}

// The environment for the service.
variable "environment" {
  type = "map"

  default = {
    "ENV1" = "value1"
    "ENV2" = "value2"
  }
}

// The volume map for the service.
variable "volumes" {
  type = "map"

  default = {
    "/path/to/volume" = "/path/to/dest"
    "named"           = "/container/path/named"
  }
}

// The overridden default command.
variable "command" {
  type    = "string"
  default = "/bin/bash -l"
}

// example_service provides our sample service.
module "example_service" {
  source          = "../"
  capabilities    = "${var.capabilities}"
  command         = "${var.command}"
  dockerfile_data = "${var.dockerfile_data}"
  environment     = "${var.environment}"
  image_name      = "${var.image_name}"
  network_mode    = "host"
  service_name    = "${var.service_name}"
  volumes         = "${var.volumes}"
}

// The write_files section for the user data.
output "write_files_entry" {
  value = "\n${module.example_service.write_files_entry}"
}

// The Docker Compose service in the rancher section of the user data.
output "rancher_service_data" {
  value = "\n${module.example_service.rancher_service_data}"
}
