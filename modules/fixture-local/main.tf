terraform {
  required_version = ">= 1.0"

  # No remote backend — state stays in the workdir so tests are isolated.
  required_providers {
    local = {
      source = "hashicorp/local"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_id" "env" {
  byte_length = 4
}

resource "local_file" "manifest" {
  filename = "${path.root}/output/manifest-${random_id.env.hex}.json"
  content = jsonencode({
    installation_uuid = var.installation_uuid
    environment_name  = var.environment_name
    hyperscaler       = var.hyperscaler
    region            = var.region
    requested_cidr    = var.requested_cidr
    module_version    = var.module_version
    provisioned_at    = timestamp()
    status            = "active"
  })
  file_permission = "0644"
}
