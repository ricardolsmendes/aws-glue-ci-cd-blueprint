module "aws_glue_ci_cd_blueprint" {
  source = "../../modules/glue"
  environment = var.environment
}
