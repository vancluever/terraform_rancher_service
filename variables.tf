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

// The network mode to use within the container. Valid values are `bridge` (the
// default), `host` for host networking, `service:[service name]` to use the
// stack of another defined service, or `container:[container name/id]` to use
// one of an existing container. If you are specifying this option here with
// Rancher, you almost always want `host`. `none` is also valid, but more than
// likely will not be helpful in a Rancher container either.
variable "network_mode" {
  type    = "string"
  default = ""
}

// A set of capabilities to add to the container, such as
// `CAP_NET_BIND_SERVICE` which will allow a container to bind to a privileged
// port (which can help when using `network_mode: host`).
variable "capabilities" {
  type    = "list"
  default = []
}

// A map of key/value pairs that can be used to pass environment variables into
// a container.
variable "environment" {
  type    = "map"
  default = {}
}

// A map of source/destination pairs that can be used to pass volumes into the
// container. See [this
// page](https://docs.docker.com/compose/compose-file/#/volumes-volumedriver)
// for information on how to specify this option.
variable "volumes" {
  type    = "map"
  default = {}
}

// Overrides the default command for the container.
variable "command" {
  type    = "string"
  default = ""
}
