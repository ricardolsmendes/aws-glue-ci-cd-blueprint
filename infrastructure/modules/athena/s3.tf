resource "aws_s3_bucket" "athena_query_results" {
  bucket = "${var.athena_query_results_bucket_name}-${var.environment}"
}

resource "aws_s3_bucket_lifecycle_configuration" "athena_query_results" {
  bucket = aws_s3_bucket.athena_query_results.id
  rule {
    status = "Enabled"
    id     = "Delete after 1 day"
    expiration {
      days = 1
    }
  }
}

# =======================================================================================
# DELETE THIS AND UNCOMMENT THE FOLLOWING RESOURCE TO ENABLE SSE-KMS ENCRYPTION IN S3.
# =======================================================================================
# resource "aws_s3_bucket_server_side_encryption_configuration" "athena_query_results" {
#   bucket = aws_s3_bucket.athena_query_results.id

#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = var.s3_data_encryption_key_arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }
