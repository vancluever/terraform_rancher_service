// module terraform_rancher_service

// The name of the service.
variable "service_name" {
  type = "string"
}

// The name of the Docker image to run this service with. More than likely this
// will exist remotely, and will be pulled for you. Using pre-built images,
// either via user data or stored on the image, is currently not supported by
// this module.
variable "image_name" {
  type = "string"
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
variable "cap_add" {
  type    = "list"
  default = []
}

// A set of capabilities to remove from the container.
variable "cap_drop" {
  type    = "list"
  default = []
}

// A map of key/value pairs that can be used to pass environment variables into
// a container. Any boolean values; `true`, `false`, `yes`, or `no`, need to be
// enclosed in quotes to ensure they are not converted to a non-string `True`
// or `False` by the YAML parser.
variable "environment" {
  type    = "map"
  default = {}
}

// A map of source:destination pairs that can be used to pass volumes into the
// container. See [this
// page](https://docs.docker.com/compose/compose-file/#/volumes-volumedriver)
// for information on how to specify this option.
//
// **NOTE**: Rancher currently uses a Version 1 Docker Compose format and does
// not support named volumes in this variable. Hence only bind volumes are
// supported.
variable "volumes" {
  type    = "list"
  default = []
}

// Overrides the default command for the container.
variable "command" {
  type    = "string"
  default = ""
}
