/**
 * # terraform_rancher_service
 * 
 * Module `terraform_rancher_service` provides a semantic way to generate
 * `cloud-config` entries suitable for use with [RancherOS][1]. The module will
 * generate a `rancher` services section - which is mostly compatible with with
 * [Docker Compose][2] Version 1. This is Rancher's pattern for managing
 * services within the operating system.
 * 
 * [1]: http://rancher.com/rancher-os/
 * [2]: https://docs.docker.com/compose/
 * 
 * This module is not necessarily intended to be used alone, but rather as a
 * building block, along with [`terraform_rancher_user_data`][3], to build a
 * complete set of user data that can then be passed to a RancherOS instance
 * (such as in AWS).
 * 
 * [3]: https://github.com/vancluever/terraform_rancher_user_data
 * 
 * This data can then be used to build custom "images" that can be used to deploy
 * a specific set of services on top of Rancher without a need to have a compute
 * image, such as an AWS AMI, pre-built, such as [`terraform_rancher_consul`][4].
 * 
 * [4]: https://github.com/vancluever/terraform_rancher_consul
 *
 * Usage Example:
 *
 *     module "service" {
 *       source = "github.com/vancluever/terraform_rancher_service"
 *     
 *       capabilities = [
 *         "CAP_1",
 *         "CAP_2",
 *       ]
 *     
 *       command = "/bin/bash -l"
 *     
 *       environment = {
 *         "ENV1" = "value1"
 *         "ENV2" = "value2"
 *       }
 *     
 *       image_name   = "foobar:latest"
 *       network_mode = "host"
 *       service_name = "foobar"
 *     
 *       volumes = [
 *         "/path/to/volume:/path/to/dest",
 *         "/var/run/docker.sock:/var/run/docker.sock",
 *       ]
 *     }
 *
 */

