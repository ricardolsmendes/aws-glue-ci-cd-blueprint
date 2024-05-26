resource "aws_s3_bucket" "data" {
  bucket = "${var.data_bucket_name}-${var.environment}"
}

# =======================================================================================
# KMS KEY ARE DISABLED BY DEFAULT. PLEASE REFER TO `kms.tf` FOR DETAILS.
# =======================================================================================
# resource "aws_s3_bucket_server_side_encryption_configuration" "data" {
#   bucket = aws_s3_bucket.data.id
#
#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.s3.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }
