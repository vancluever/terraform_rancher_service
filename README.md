# terraform_rancher_service

Module `terraform_rancher_service` provides a semantic way to generate
`cloud-config` entries suitable for use with [RancherOS][1]. The module will
generate a `rancher` services section - which is mostly compatible with with
[Docker Compose][2] Version 1. This is Rancher's pattern for managing
services within the operating system.

[1]: http://rancher.com/rancher-os/
[2]: https://docs.docker.com/compose/

This module is not necessarily intended to be used alone, but rather as a
building block, along with [`terraform_rancher_user_data`][3], to build a
complete set of user data that can then be passed to a RancherOS instance
(such as in AWS).

[3]: https://github.com/vancluever/terraform_rancher_user_data

This data can then be used to build custom "images" that can be used to deploy
a specific set of services on top of Rancher without a need to have a compute
image, such as an AWS AMI, pre-built, such as [`terraform_rancher_consul`][4].

[4]: https://github.com/vancluever/terraform_rancher_consul

Usage Example:

    module "service" {
      source = "github.com/vancluever/terraform_rancher_service"

      capabilities = [
        "CAP_1",
        "CAP_2",
      ]

      command = "/bin/bash -l"

      environment = {
        "ENV1" = "value1"
        "ENV2" = "value2"
      }

      image_name   = "foobar:latest"
      network_mode = "host"
      service_name = "foobar"

      volumes = [
        "/path/to/volume:/path/to/dest",
        "/var/run/docker.sock:/var/run/docker.sock",
      ]
    }



## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| service_name | The name of the service. | - | yes |
| image_name | The name of the Docker image to run this service with. More than likely this will exist remotely, and will be pulled for you. Using pre-built images, either via user data or stored on the image, is currently not supported by this module. | - | yes |
| network_mode | The network mode to use within the container. Valid values are `bridge` (the default), `host` for host networking, `service:[service name]` to use the stack of another defined service, or `container:[container name/id]` to use one of an existing container. If you are specifying this option here with Rancher, you almost always want `host`. `none` is also valid, but more than likely will not be helpful in a Rancher container either. | `` | no |
| capabilities | A set of capabilities to add to the container, such as `CAP_NET_BIND_SERVICE` which will allow a container to bind to a privileged port (which can help when using `network_mode: host`). | `<list>` | no |
| environment | A map of key/value pairs that can be used to pass environment variables into a container. | `<map>` | no |
| volumes | A map of source:destination pairs that can be used to pass volumes into the container. See [this page](https://docs.docker.com/compose/compose-file/#/volumes-volumedriver) for information on how to specify this option.<br><br>**NOTE**: Rancher currently uses a Version 1 Docker Compose format and does not support named volumes in this variable. Hence only bind volumes are supported. | `<list>` | no |
| command | Overrides the default command for the container. | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| rancher_service_data | The Docker Compose service in the rancher section of the user data. |

