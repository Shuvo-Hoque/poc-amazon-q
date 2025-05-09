resource "aws_sns_topic" "sns_topics" {
  for_each = toset(var.sns_topic_names)
  name     = "${var.environment}-${each.value}"
}