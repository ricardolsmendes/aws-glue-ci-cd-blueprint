module "iam" {
  source = "../iam"
}

module "s3" {
  source = "../s3"
}

resource "aws_glue_job" "sample_spark_job" {
  name     = "sample-spark-job-${var.environment}"
  role_arn = module.iam.glue_service_role_arn

  command {
    script_location = module.s3.glue_scripts_bucket_id
  }
}
