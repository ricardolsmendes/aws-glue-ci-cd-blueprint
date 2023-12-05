resource "aws_s3_bucket" "athena_query_results" {
  bucket = "${var.athena_query_results_bucket_name}-${var.environment}"
  tags   = local.default_tags
}

resource "aws_s3_bucket_lifecycle_configuration" "athena_query_results_lifecycle" {
  bucket = aws_s3_bucket.athena_query_results.id
  rule {
    status = "Enabled"
    id     = "Delete after 1 day"
    expiration {
      days = 1
    }
  }
}
