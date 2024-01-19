resource "aws_s3_bucket" "glue" {
  for_each = local.buckets_map

  bucket = each.value.name
}

resource "aws_s3_bucket_lifecycle_configuration" "glue_assets" {
  bucket = aws_s3_bucket.glue["assets"].id

  rule {
    status = "Enabled"
    id     = "Delete after 30 days"

    expiration {
      days = 30
    }
  }
}
