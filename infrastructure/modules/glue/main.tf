module "iam" {
  source = "../iam"
}

module "s3" {
  source = "../s3"
}

module "shared" {
  source = "../shared"
}

resource "aws_glue_job" "sample_spark_job" {
  name         = "${var.sample_spark_job_name}-${module.shared.environment}"
  description  = "Sample Spark job from the AWS Glue CI/CD Blueprint"
  glue_version = "4.0"
  role_arn     = module.iam.glue_service_role_arn
  command {
    script_location = module.s3.glue_scripts_bucket_id
  }
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = module.shared.environment
  }
}
