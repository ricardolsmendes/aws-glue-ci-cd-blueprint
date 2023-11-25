data "aws_iam_role" "glue_service" {
  name = var.glue_service_role_id
}

data "aws_s3_bucket" "glue_scripts" {
  bucket = var.glue_scripts_bucket_id
}

resource "aws_glue_job" "sample_bronze_job" {
  name              = "${var.sample_bronze_job_name}-${var.environment}"
  description       = "Sample Bronze-layer job from the AWS Glue CI/CD Blueprint."
  glue_version      = "4.0"
  role_arn          = data.aws_iam_role.glue_service.arn
  worker_type       = "G.1X"
  number_of_workers = 10
  command {
    script_location = "s3://${data.aws_s3_bucket.glue_scripts.id}/sample_bronze_job.py"
  }
  default_arguments = {
    "--source-bucket-name" = "awsglue-datasets",
    "--source-file-path"   = "examples/us-legislators/all/persons.json",
    "--target-bucket-name" = var.data_bucket_id,
    "--target-file-path"   = "bronze/us-legislators/all-persons.json",
  }
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}

resource "aws_glue_job" "sample_silver_job" {
  name              = "${var.sample_silver_job_name}-${var.environment}"
  description       = "Sample Silver-layer job from the AWS Glue CI/CD Blueprint."
  glue_version      = "4.0"
  role_arn          = data.aws_iam_role.glue_service.arn
  worker_type       = "G.1X"
  number_of_workers = 10
  command {
    script_location = "s3://${data.aws_s3_bucket.glue_scripts.id}/sample_silver_job.py"
  }
  default_arguments = {
    "--source-bucket-name" = var.data_bucket_id,
    "--source-file-path"   = "bronze/us-legislators/all-persons.json",
    "--target-bucket-name" = var.data_bucket_id,
    "--target-table-path"  = "silver/us-legislators",
  }
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}
