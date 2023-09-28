module "aws_glue_ci_cd_blueprint_prerequisites" {
  source = "../../../modules/iam"

  environment              = var.environment
  data_bucket_name         = var.data_bucket_name
  glue_assets_bucket_name  = var.glue_assets_bucket_name
  glue_scripts_bucket_name = var.glue_scripts_bucket_name
}
