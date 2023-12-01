locals {
  default_tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}
