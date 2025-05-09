module "sns_primary" {
  source          = "../../../modules/sns"
  sns_topic_names = var.primary_sns_topic_names
  environment     = var.environment
  providers = {
    aws= aws.primary
  }
}

module "sns_secondary" {
  source          = "../../../modules/sns"
  sns_topic_names = var.secondary_sns_topic_names
  environment     = var.environment
  providers = {
    aws = aws.secondary
  }
}