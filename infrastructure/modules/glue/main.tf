module "iam" {
  source = "../iam"
  environment = var.environment
}

module "s3" {
  source = "../s3"
  environment = var.environment
}

resource "aws_glue_job" "sample_spark_job" {
  name              = "${var.sample_spark_job_name}-${var.environment}"
  description       = "Sample Spark job from the AWS Glue CI/CD Blueprint."
  glue_version      = "4.0"
  role_arn          = module.iam.glue_service_role_arn
  worker_type       = "G.1X"
  number_of_workers = 10
  command {
    script_location = module.s3.glue_scripts_bucket_id
  }
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}
