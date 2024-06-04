output "data_bucket_id" {
  value = aws_s3_bucket.data.id
}

# =======================================================================================
# KMS KEYS ARE NOT CREATED BY DEFAULT. PLEASE REFER TO `kms.tf` FOR DETAILS.
# =======================================================================================
# output "s3_data_encryption_key_arn" {
#   value = aws_kms_key.s3_data.arn
# }
