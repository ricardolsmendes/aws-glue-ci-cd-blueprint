output "glue_scripts_bucket_id" {
  value = aws_s3_bucket.glue_scripts.id
}

output "glue_service_role_id" {
  value = aws_iam_role.glue_service_role.id
}
