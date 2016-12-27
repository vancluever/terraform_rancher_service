// module terraform_rancher_service

// The name of the service.
variable "service_name" {
  type = "string"
}

// The Dockerfile data for the service. A combination of this, or `image_name`
// needs to be supplied. The effect varies, depending on what is supplied:
//
//  * `dockerfile_data` only: A random name is chosen for the image.
//
//  * `image_name` only: The docker image is pulled from the referenced
//     registry and repository.
//
//  * Both `dockerfile_data` and `image_name`: A new image is built off of the
//    data, and used.
//
// This behaviour is actually controlled by Docker Compose, found
// [here](https://docs.docker.com/compose/compose-file/#/service-configuration-reference).
//
// Either this or `image_name` needs to be supplied, or else the module will
// exhibit undefined behaviour.
variable "dockerfile_data" {
  type    = "string"
  default = ""
}

// A Docker image name, either as an image to pull for the service or a name to
// name the resulting image built from the supplied Dockerfile data. See the
// `dockerfile_data` variable for information on how this variable interacts
// with any data supplied there.
//
// Either this or `dockerfile_data` needs to be supplied, or else the module
// will exhibit undefined behaviour.
variable "image_name" {
  type    = "string"
  default = ""
}
