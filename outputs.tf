// The `write_files` section for the user data.
output "write_files_entry" {
  value = <<EOS
  - path: /tmp/Dockerfile.${var.service_name}
    content: ${base64encode(var.dockerfile_data)}
    encoding: b64
EOS
}

// The Docker Compose service in the rancher section of the user data.
output "rancher_service_data" {
  value = <<EOS
    ${var.service_name}:
      ${var.dockerfile_data != "" ? format("dockerfile: /tmp/Dockerfile.%s", var.service_name) : "" }
      ${var.image_name != "" ? format("image: %s", var.image_name) : "" }
EOS
}
