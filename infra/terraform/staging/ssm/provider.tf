terraform {
  required_version = ">= 1.5.2, <= 1.6.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.54.0"
    }
  }
}
  }
  backend "s3" {
    bucket  = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    key     = "terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }
    bucket  = "staging--poc-shuvo-terraform-state"
}
  }
  backend "s3" {
    bucket  = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    key     = "terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }
    region  = "ap-southeast-1"
    encrypt = true
  }
}
provider "aws" {
  region = "ap-southeast-1"
}
