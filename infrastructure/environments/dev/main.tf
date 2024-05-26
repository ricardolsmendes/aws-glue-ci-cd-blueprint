module "core" {
  source = "../../modules/core"

  environment      = var.environment
  data_bucket_name = var.data_bucket_name
}

module "glue" {
  source = "../../modules/glue"

  environment    = var.environment
  data_bucket_id = module.core.data_bucket_id
  # =====================================================================================
  # DELETE THIS AND UNCOMMENT THE FOLLOWING LINE TO ENABLE SSE-KMS ENCRYPTION IN S3.
  # =====================================================================================
  # s3_encryption_key_arn  = module.core.s3_encryption_key_arn
  glue_assets_bucket_name  = var.glue_assets_bucket_name
  glue_scripts_bucket_name = var.glue_scripts_bucket_name
}

module "athena" {
  source = "../../modules/athena"

  environment                      = var.environment
  athena_query_results_bucket_name = var.athena_query_results_bucket_name
  data_bucket_id                   = module.core.data_bucket_id
  silver_database_name             = module.glue.silver_database_name
}
