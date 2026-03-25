# Root module for Terraform Registry: wraps modules/fixture-local so this repo
# can be consumed at the default module path (not only via //modules/...).

terraform {
  required_version = ">= 1.0"

  required_providers {
    local = {
      source = "hashicorp/local"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

module "fixture_local" {
  source = "./modules/fixture-local"

  installation_uuid = var.installation_uuid
  environment_name  = var.environment_name
  hyperscaler       = var.hyperscaler
  region            = var.region
  requested_cidr    = var.requested_cidr
  module_version    = var.module_version
}
