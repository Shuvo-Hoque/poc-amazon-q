variable "environment" {
  type        = string
  description = "AWS Environment Name:"

  validation {
    condition     = contains(["local", "staging", "production"], var.environment)
    error_message = "Valid values for 'environment' variable are (local, staging, production)."
  }
}
