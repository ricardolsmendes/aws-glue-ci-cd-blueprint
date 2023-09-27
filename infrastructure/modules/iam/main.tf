module "s3" {
  source = "../s3"
  environment = var.environment
}

data "aws_iam_policy_document" "glue_service_custom_policy" {
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
  name        = "AWSGlueCICDBlueprintGluePolicy-${var.environment}"
  description = "Provides access to the resources required by Glue jobs in the AWS Glue CI/CD Blueprint."
  policy      = data.aws_iam_policy_document.glue_service_custom_policy.json
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "glue_service_trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "glue_service_role" {
  name               = "AWSGlueCICDBlueprintGlueServiceRole-${var.environment}"
  description        = "Used by Glue to demonstrate the AWS Glue CI/CD Blueprint."
  assume_role_policy = data.aws_iam_policy_document.glue_service_trust_policy.json
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "glue_service_custom_policy_attachment" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = aws_iam_policy.glue_service_custom_policy.arn
}

resource "aws_iam_role_policy_attachment" "glue_service_managed_policy_attachment" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
