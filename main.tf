terraform {
  required_version = ">= 1.0.0"

  #   backend "s3" {
  #     bucket = "tc-g13-tf-state"
  #     key    = "tech-challenge-foundation.tfstate"
  #     region = "us-east-1"
  #   }

  cloud {
    organization = "fiap-pos-tech"

    workspaces {
      name = "infra-foundation"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.56.0"
    }
  }
}

provider "aws" {
  profile             = var.aws_profile
  region              = "us-east-1"
  allowed_account_ids = ["212517236385"]

  default_tags {
    tags = {
      "worload" = "foundation"
    }
  }
}