// module terraform_rancher_service

// environment_map_formatted provides a formatted key/value pair for provided environment variables.
data "template_file" "environment_map_formatted" {
  count    = "${length(var.environment)}"
  template = "${element(keys(var.environment), count.index)}: ${element(values(var.environment), count.index)}"
}

// rancher_service_data_template provides a template to render the Docker
// Compose service in the rancher section of the user data.
//
// Empty strings are replaced with "~~" - these are trimmed from the final
// content, along with any leading whitespace.
data "template_file" "rancher_service_data" {
  template = <<EOS
    ${var.service_name}:
      ${length(var.capabilities) > 0 ? format("capabilities:\n        - %s", join("\n        - ", var.capabilities)) : "~~" }
      ${var.command != "" ? format("command: %s", var.command) : "~~" }
      ${length(var.environment) > 0 ? format("environment:\n        %s", join("\n        ", data.template_file.environment_map_formatted.*.rendered)) : "~~" }
      image: ${var.image_name}
      ${var.network_mode != "" ? format("net: %s", var.network_mode) : "~~" }
      ${length(var.volumes) > 0 ? format("volumes:\n        - %s", join("\n        - ", var.volumes)) : "~~" }
EOS
}
