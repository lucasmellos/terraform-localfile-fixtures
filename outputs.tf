output "installation_uuid" {
  value       = module.fixture_local.installation_uuid
  description = "The installation UUID from control-tower"
}

output "environment_name" {
  value       = module.fixture_local.environment_name
  description = "The provisioned environment name"
}

output "vpc_id" {
  value       = module.fixture_local.vpc_id
  description = "Simulated VPC ID"
}

output "subnet_cidr" {
  value       = module.fixture_local.subnet_cidr
  description = "The CIDR block assigned to the environment"
}

output "region" {
  value       = module.fixture_local.region
  description = "The region where resources were provisioned"
}

output "manifest_path" {
  value       = module.fixture_local.manifest_path
  description = "Path to the generated manifest file"
}
