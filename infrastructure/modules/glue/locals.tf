locals {
  default_tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
    CreatedBy   = "Terraform"
  }

  buckets_map = {
    assets = {
      name = "${var.glue_assets_bucket_name}-${var.environment}"
    },
    scripts = {
      name = "${var.glue_scripts_bucket_name}-${var.environment}"
    }
  }
}
