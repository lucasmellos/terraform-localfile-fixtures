# Test fixture: always fails on apply (exits with error).
# Used to exercise the provisioner's retry, compensation, and manual-review paths.
#
# Set TF_VAR_fail=false to make it succeed (useful for testing compensation after retry).

terraform {
  required_version = ">= 1.0"
}

variable "fail" {
  description = "When true, the apply will fail with a simulated error"
  type        = bool
  default     = true
}

variable "installation_uuid" {
  description = "Installation UUID assigned by control-tower"
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

# This null_resource will fail on create when var.fail is true.
# The provisioner runs a shell command that exits non-zero.
resource "terraform_data" "check" {
  input = var.fail

  provisioner "local-exec" {
    command = var.fail ? "echo 'SIMULATED FAILURE: provisioning error for ${var.installation_uuid}' >&2 && exit 1" : "echo 'OK'"
  }
}

output "installation_uuid" {
  value = var.installation_uuid
}

output "status" {
  value = var.fail ? "failed" : "succeeded"
}
