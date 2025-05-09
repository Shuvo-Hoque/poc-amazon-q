terraform {
  required_version = ">= 1.5.2, <= 1.6.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.54.0"
    }
  }
  backend "s3" {
    bucket  = "production--poc-shuvo-terraform-state"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
provider "aws" {
  alias = "primary"
  region = "ap-southeast-4"
}

provider "aws" {
  alias = "secondary"
  region = "us-east-1"
}