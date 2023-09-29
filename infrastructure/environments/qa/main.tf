module "core" {
  source = "../../modules/core"

  environment              = var.environment
  data_bucket_name         = var.data_bucket_name
  glue_assets_bucket_name  = var.glue_assets_bucket_name
  glue_scripts_bucket_name = var.glue_scripts_bucket_name
}

module "pipelines" {
  source = "../../modules/pipelines"

  environment            = var.environment
  glue_scripts_bucket_id = module.core.glue_scripts_bucket_id
  glue_service_role_id   = module.core.glue_service_role_id
  sample_spark_job_name  = var.sample_spark_job_name
}
