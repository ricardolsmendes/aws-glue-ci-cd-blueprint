resource "aws_glue_job" "bronze_us_legislators" {
  name              = "glue-ci-cd-bronze-us-legislators-${var.environment}"
  description       = "Sample Bronze-layer job for the AWS Glue CI/CD Blueprint."
  role_arn          = aws_iam_role.glue_service.arn
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = 2
  execution_class   = "FLEX"
  default_arguments = {
    "--source-bucket-name" = "awsglue-datasets",
    "--source-file-path"   = "examples/us-legislators/all/persons.json",
    "--target-bucket-name" = var.data_bucket_id,
    "--target-file-path"   = "bronze/awsglue-datasets/us-legislators/all-persons.json",
  }
  tags = local.default_tags
  command {
    script_location = "s3://${aws_s3_bucket.glue["scripts"].id}/s3_to_s3_job.py"
  }
}

resource "aws_glue_job" "silver_us_legislators" {
  name              = "glue-ci-cd-silver-us-legislators-${var.environment}"
  description       = "Sample Silver-layer job for the AWS Glue CI/CD Blueprint."
  role_arn          = aws_iam_role.glue_service.arn
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = 2
  execution_class   = "FLEX"
  default_arguments = {
    "--source-bucket-name" = var.data_bucket_id,
    "--source-file-path"   = "bronze/awsglue-datasets/us-legislators/all-persons.json",
    "--target-bucket-name" = var.data_bucket_id,
    "--target-table-path"  = "silver/us-legislators",
  }
  tags = local.default_tags
  command {
    script_location = "s3://${aws_s3_bucket.glue["scripts"].id}/s3_json_to_parquet_job.py"
  }
}
