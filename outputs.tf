// module terraform_rancher_service

// The `write_files` section for the user data. This value will be incomplete
// if you are not using a Dockerfile.
output "write_files_entry" {
  value = <<EOS
  - path: /tmp/Dockerfile.${var.service_name}
    content: ${base64encode(var.dockerfile_data)}
    encoding: b64
EOS
}

// The Docker Compose service in the rancher section of the user data.
output "rancher_service_data" {
  value = "${format("    %s:\n", var.service_name)}${var.dockerfile_data != "" ? format("      dockerfile: /tmp/Dockerfile.%s\n", var.service_name) : "" }${var.image_name != "" ? format("      image: %s\n", var.image_name) : "" }${var.network_mode != "" ? format("      network_mode: %s", var.network_mode) : "" }"
}
