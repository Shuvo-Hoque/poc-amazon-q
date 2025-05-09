terraform {
  required_version = ">= 1.5.2, <= 1.6.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.54.0"
    }
  }
}
