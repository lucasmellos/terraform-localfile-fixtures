# Test fixture: uses only local providers (no cloud credentials needed).
# Simulates a realistic init/plan/apply/destroy cycle by creating a local
# file and exposing outputs that mirror a real module (vpc_id, subnet, etc.).
#
# Used by e2e tests in internal/terraformexec and internal/provisioner.

terraform {
  required_version = ">= 1.0"

  # No remote backend — state stays in the workdir so tests are isolated.
}

variable "environment_name" {
  description = "Name of the environment being provisioned"
  type        = string
  default     = "e2e-test"
}

variable "region" {
  description = "Simulated cloud region"
  type        = string
  default     = "us-east-1"
}

variable "requested_cidr" {
  description = "Requested CIDR block for the environment"
  type        = string
  default     = "10.42.0.0/16"
}

variable "hyperscaler" {
  description = "Cloud provider identifier"
  type        = string
  default     = "aws"
}

variable "module_version" {
  description = "Module version being deployed"
  type        = string
  default     = "v1.0.0-test"
}

variable "installation_uuid" {
  description = "Installation UUID assigned by control-tower"
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

# --- Resources ---

resource "random_id" "env" {
  byte_length = 4
}

resource "local_file" "manifest" {
  filename = "${path.module}/output/manifest-${random_id.env.hex}.json"
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

# --- Outputs (mirror what a real infrastructure module would expose) ---

output "installation_uuid" {
  value       = var.installation_uuid
  description = "The installation UUID from control-tower"
}

output "environment_name" {
  value       = var.environment_name
  description = "The provisioned environment name"
}

output "vpc_id" {
  value       = "vpc-${random_id.env.hex}"
  description = "Simulated VPC ID"
}

output "subnet_cidr" {
  value       = var.requested_cidr
  description = "The CIDR block assigned to the environment"
}

output "region" {
  value       = var.region
  description = "The region where resources were provisioned"
}

output "manifest_path" {
  value       = local_file.manifest.filename
  description = "Path to the generated manifest file"
}
