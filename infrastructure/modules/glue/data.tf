data "aws_iam_role" "glue_service" {
  name = var.glue_service_role_id
}

data "aws_s3_bucket" "glue_scripts" {
  bucket = var.glue_scripts_bucket_id
}
