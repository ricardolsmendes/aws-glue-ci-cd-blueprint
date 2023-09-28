module "aws_glue_ci_cd_blueprint_prerequisites" {
  source = "../../../modules/glue"

  environment              = var.environment
  glue_scripts_bucket_name = var.glue_scripts_bucket_name
  sample_spark_job_name    = var.sample_spark_job_name
}
