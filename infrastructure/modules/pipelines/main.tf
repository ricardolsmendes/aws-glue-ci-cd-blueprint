data "aws_iam_role" "glue_service" {
  name = var.glue_service_role_id
}

data "aws_s3_bucket" "glue_scripts" {
  bucket = var.glue_scripts_bucket_id
}

resource "aws_glue_job" "sample_spark_job" {
  name              = "${var.sample_spark_job_name}-${var.environment}"
  description       = "Sample Spark job from the AWS Glue CI/CD Blueprint."
  glue_version      = "4.0"
  role_arn          = data.aws_iam_role.glue_service.arn
  worker_type       = "G.1X"
  number_of_workers = 10
  command {
    script_location = data.aws_s3_bucket.glue_scripts.id
  }
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}
