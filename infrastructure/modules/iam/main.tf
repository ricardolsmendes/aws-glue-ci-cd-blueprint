module "s3" {
  source = "../s3"
}

module "shared" {
  source = "../shared"
}

data "aws_iam_policy_document" "glue_service_custom_policy_data" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = [module.s3.glue_scripts_bucket_arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      module.s3.data_bucket_arn,
      module.s3.glue_assets_bucket_arn
    ]
  }
}

resource "aws_iam_policy" "glue_service_custom_policy" {
  name        = "AWSGlueCICDBlueprintPolicy-${module.shared.environment}"
  description = "Allows Glue to use other AWS services"
  policy      = data.aws_iam_policy_document.glue_service_custom_policy_data.json
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = module.shared.environment
  }
}

resource "aws_iam_role" "glue_service_role" {
  name               = "AWSGlueCICDBlueprintServiceRole-${module.shared.environment}"
  description        = "Allows Glue to call AWS services"
  assume_role_policy = aws_iam_policy.glue_service_custom_policy.arn
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = module.shared.environment
  }
}

resource "aws_iam_role_policy_attachment" "glue_service_managed_policy_attachment" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueServiceRole"
}
