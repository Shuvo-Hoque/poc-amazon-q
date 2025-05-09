variable "primary_sns_topic_names" {
  description = "List of primary SNS topic names to create"
  type        = list(string)
}
variable "secondary_sns_topic_names" {
  description = "List of secondary SNS topic names to create"
  type        = list(map(string))
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}