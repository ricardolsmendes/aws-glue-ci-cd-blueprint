resource "aws_iam_policy" "glue_service_custom_policy" {
  name        = "GlueCICDPolicy-${var.environment}"
  description = "Provides access to the resources required by Glue services."
  policy      = data.aws_iam_policy_document.glue_service_custom_policy.json
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

resource "aws_iam_role" "glue_service_role" {
  name               = "GlueCICDServiceRole-${var.environment}"
  description        = "Used by Glue to demonstrate the CI/CD Blueprint."
  assume_role_policy = data.aws_iam_policy_document.glue_service_trust_policy.json
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
    CreatedBy   = "Terraform"
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
