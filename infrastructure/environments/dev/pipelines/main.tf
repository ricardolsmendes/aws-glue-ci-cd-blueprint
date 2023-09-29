module "pipelines" {
  source = "../../../modules/pipelines"

  environment              = var.environment
  glue_scripts_bucket_name = var.glue_scripts_bucket_name
  sample_spark_job_name    = var.sample_spark_job_name
}
