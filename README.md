# terraform_rancher_service

Module `terraform_rancher_service` provides a semantic way to generate
`cloud-config` entries suitable for use with [RancherOS][1]. The module will
generate both a `write_files` and a `rancher` services section - the latter
being compatible with [Docker Compose][2], which is Rancher's pattern for
managing services within the operating system.

[1]: http://rancher.com/rancher-os/
[2]: https://docs.docker.com/compose/

This module is not necessarily intended to be used as a building block, along
with [`terraform_rancher_user_data`][3], to build a complete set of user data
that can then be passed to a RancherOS instance (such as in AWS).

[3]: https://github.com/vancluever/terraform_rancher_user_data

This data can then be used to build custom "images" that can be used to deploy
a specific set of services on top of Rancher without a need to have a compute
image, such as an AWS AMI, pre-built, such as [`terraform_rancher_consul`][4].

[4]: https://github.com/vancluever/terraform_rancher_consul

## Modes

Since Rancher system services are basically just Docker Compose entries, the
same rules are followed when `Dockerfile` path, image names, or both, are
supplied. See the variables section of the documentation for specific
information.


## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| service_name | The name of the service. | - | yes |
| dockerfile_data | The Dockerfile data for the service. A combination of this, or `image_name` needs to be supplied. The effect varies, depending on what is supplied:<br><br>* `dockerfile_data` only: A random name is chosen for the image.<br><br>* `image_name` only: The docker image is pulled from the referenced registry and repository.<br><br>* Both `dockerfile_data` and `image_name`: A new image is built off of the data, and used.<br><br>This behaviour is actually controlled by Docker Compose, found [here](https://docs.docker.com/compose/compose-file/#/service-configuration-reference).<br><br>Either this or `image_name` needs to be supplied, or else the module will exhibit undefined behaviour. | `` | no |
| image_name | A Docker image name, either as an image to pull for the service or a name to name the resulting image built from the supplied Dockerfile data. See the `dockerfile_data` variable for information on how this variable interacts with any data supplied there.<br><br>Either this or `dockerfile_data` needs to be supplied, or else the module will exhibit undefined behaviour. | `` | no |
| network_mode | The network mode to use within the container. Valid values are `bridge` (the default), `host` for host networking, `service:[service name]` to use the stack of another defined service, or `container:[container name/id]` to use one of an existing container. If you are specifying this option here with Rancher, you almost always want `host`. `none` is also valid, but more than likely will not be helpful in a Rancher container either. | `` | no |
| capabilities | A set of capabilities to add to the container, such as `CAP_NET_BIND_SERVICE` which will allow a container to bind to a privileged port (which can help when using `network_mode: host`). | `<list>` | no |
| environment | A map of key/value pairs that can be used to pass environment variables into a container. | `<map>` | no |
| volumes | A map of source/destination pairs that can be used to pass volumes into the container. See [this page](https://docs.docker.com/compose/compose-file/#/volumes-volumedriver) for information on how to specify this option. | `<map>` | no |
| command | Overrides the default command for the container. | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| write_files_entry | The `write_files` section for the user data. This value will be incomplete if you are not using a Dockerfile. |
| rancher_service_data | The Docker Compose service in the rancher section of the user data. |

