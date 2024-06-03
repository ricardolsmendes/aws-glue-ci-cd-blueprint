output "data_bucket_id" {
  value = aws_s3_bucket.data.id
}

# =======================================================================================
# THE KMS KEY IS NOT CREATED BY DEFAULT. PLEASE REFER TO `kms.tf` FOR DETAILS.
# =======================================================================================
output "s3_encryption_key_arn" {
  value = aws_kms_key.s3.arn
}
