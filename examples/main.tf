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

// The capabilities to add for this service.
variable "cap_add" {
  type = "list"

  default = [
    "CAP_1",
    "CAP_2",
  ]
}

// The capabilities to drop for this service.
variable "cap_drop" {
  type = "list"

  default = [
    "CAP_3",
    "CAP_4",
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
  type = "list"

  default = [
    "/path/to/volume:/path/to/dest",
    "/var/run/docker.sock:/var/run/docker.sock",
  ]
}

// The overridden default command.
variable "command" {
  type    = "string"
  default = "/bin/bash -l"
}

// example_service provides our sample service.
module "example_service" {
  source       = "../"
  cap_add      = "${var.cap_add}"
  cap_drop     = "${var.cap_drop}"
  command      = "${var.command}"
  environment  = "${var.environment}"
  image_name   = "${var.image_name}"
  network_mode = "host"
  service_name = "${var.service_name}"
  volumes      = "${var.volumes}"
}

// The Docker Compose service in the rancher section of the user data.
output "rancher_service_data" {
  value = "\n${module.example_service.rancher_service_data}"
}
