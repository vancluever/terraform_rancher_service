// module terraform_rancher_service

// rancher_service_data_template provides a template to render the Docker
// Compose service in the rancher section of the user data.
//
// Empty strings are replaced with "~~" - these are trimmed from the final
// content, along with any leading whitespace.
data "template_file" "rancher_service_data" {
  template = <<EOS
    $${service_name}:
      $${dockerfile_data != "" ? format("dockerfile: /tmp/Dockerfile.%s", service_name) : "~~" }
      $${image_name != "" ? format("image: %s", image_name) : "~~" }
      $${network_mode != "" ? format("network_mode: %s", network_mode) : "~~" }
EOS

  vars {
    service_name    = "${var.service_name}"
    dockerfile_data = "${var.dockerfile_data}"
    image_name      = "${var.image_name}"
    network_mode    = "${var.network_mode}"
  }
}
