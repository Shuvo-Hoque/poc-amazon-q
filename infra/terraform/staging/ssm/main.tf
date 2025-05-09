module "ssm" {
  source          = "../../../modules/ssm/port-forwarding-document"
  environment     = var.environment
}
