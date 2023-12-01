resource "aws_iam_policy" "glue_service_custom_policy" {
  name        = "GlueCICDPolicy-${var.environment}"
  description = "Grants access to the resources required by Glue services."
  policy      = data.aws_iam_policy_document.glue_service_custom_policy.json
  tags        = local.default_tags
}

resource "aws_iam_role" "glue_service_role" {
  name               = "GlueCICDServiceRole-${var.environment}"
  description        = "Role assumed by the Glue services to demonstrate the CI/CD Blueprint."
  assume_role_policy = data.aws_iam_policy_document.glue_service_trust_policy.json
  tags               = local.default_tags
}

resource "aws_iam_role_policy_attachment" "glue_service_custom_policy_attachment" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = aws_iam_policy.glue_service_custom_policy.arn
}

resource "aws_iam_role_policy_attachment" "glue_service_managed_policy_attachment" {
  role       = aws_iam_role.glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
