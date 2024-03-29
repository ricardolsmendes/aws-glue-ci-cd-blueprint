terraform {
  backend "s3" {
    bucket = "glue-ci-cd-terraform"
    key    = "state/prod.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region

  default_tags {
    tags = {
      Project     = "AWS Glue CI/CD Blueprint"
      Environment = var.environment
      CreatedBy   = "Terraform"
    }
  }
}
