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
