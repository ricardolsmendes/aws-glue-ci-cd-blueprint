resource "aws_glue_job" "us_legislators_bronze_job" {
  name              = "aws-glue-ci-cd-blueprint-bronze-job-${var.environment}"
  description       = "Sample Bronze-layer job for the AWS Glue CI/CD Blueprint."
  glue_version      = "4.0"
  role_arn          = data.aws_iam_role.glue_service.arn
  worker_type       = "G.1X"
  number_of_workers = 10
  command {
    script_location = "s3://${data.aws_s3_bucket.glue_scripts.id}/s3_to_s3_job.py"
  }
  default_arguments = {
    "--source-bucket-name" = "awsglue-datasets",
    "--source-file-path"   = "examples/us-legislators/all/persons.json",
    "--target-bucket-name" = var.data_bucket_id,
    "--target-file-path"   = "bronze/awsglue-datasets/us-legislators/all-persons.json",
  }
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}

resource "aws_glue_job" "us_legislators_silver_job" {
  name              = "aws-glue-ci-cd-blueprint-silver-job-${var.environment}"
  description       = "Sample Silver-layer job for the AWS Glue CI/CD Blueprint."
  glue_version      = "4.0"
  role_arn          = data.aws_iam_role.glue_service.arn
  worker_type       = "G.1X"
  number_of_workers = 10
  command {
    script_location = "s3://${data.aws_s3_bucket.glue_scripts.id}/s3_json_to_parquet_job.py"
  }
  default_arguments = {
    "--source-bucket-name" = var.data_bucket_id,
    "--source-file-path"   = "bronze/awsglue-datasets/us-legislators/all-persons.json",
    "--target-bucket-name" = var.data_bucket_id,
    "--target-table-path"  = "silver/us-legislators",
  }
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}
