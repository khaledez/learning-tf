terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }

  cloud {
    organization = "khaledez-learning"
    hostname     = "app.terraform.io"
    workspaces {
      name = "web"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
