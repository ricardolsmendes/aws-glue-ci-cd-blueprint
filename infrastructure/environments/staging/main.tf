module "shared" {
  source = "../shared"
}

module "aws_glue_ci_cd_blueprint" {
  source = "../../modules/glue"
}
