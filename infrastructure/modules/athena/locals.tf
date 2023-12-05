locals {
  default_tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
  glue_resource_arn_prefix = "arn:aws:glue:${var.aws_region}:${data.aws_caller_identity.current.account_id}"
}
