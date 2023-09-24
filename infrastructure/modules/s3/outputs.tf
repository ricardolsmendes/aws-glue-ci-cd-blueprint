output "data_bucket_arn" {
  value = aws_s3_bucket.data.arn
}

output "glue_assets_bucket_arn" {
  value = aws_s3_bucket.glue_assets.arn
}

output "glue_scripts_bucket_arn" {
  value = aws_s3_bucket.glue_scripts.arn
}

output "glue_scripts_bucket_id" {
  value = aws_s3_bucket.glue_scripts.id
}
