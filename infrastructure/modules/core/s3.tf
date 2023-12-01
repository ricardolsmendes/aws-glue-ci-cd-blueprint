resource "aws_s3_bucket" "data" {
  bucket = "${var.data_bucket_name}-${var.environment}"
  tags   = var.default_tags
}

resource "aws_s3_bucket" "glue_assets" {
  bucket = "${var.glue_assets_bucket_name}-${var.environment}"
  tags   = var.default_tags
}

resource "aws_s3_bucket_lifecycle_configuration" "glue_assets_lifecycle" {
  bucket = aws_s3_bucket.glue_assets.id
  rule {
    status = "Enabled"
    id     = "Delete after 30 days"
    expiration {
      days = 30
    }
  }
}

resource "aws_s3_bucket" "glue_scripts" {
  bucket = "${var.glue_scripts_bucket_name}-${var.environment}"
  tags   = var.default_tags
}
