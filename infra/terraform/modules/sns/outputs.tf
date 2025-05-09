output "sns_topic_arns" {
  description = "A map of SNS topic ARNs"
  value       = { for k, v in aws_sns_topic.sns_topics : k => v.arn }
}

output "sns_topic_names" {
  description = "A list of all SNS topic names"
  value       = [for v in aws_sns_topic.sns_topics : v.name]
}