resource "aws_s3_bucket" "data" {
  bucket = "${var.data_bucket_name}-${var.environment}"
  tags   = local.default_tags
}
