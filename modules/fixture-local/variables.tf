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
