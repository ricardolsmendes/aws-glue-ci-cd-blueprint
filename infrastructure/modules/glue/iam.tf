resource "aws_iam_policy" "glue_service_custom" {
  name        = "GlueCICDServicePolicy-${var.environment}"
  description = "Grants access to the resources required by Glue services."
  policy      = data.aws_iam_policy_document.glue_service_custom.json
}

resource "aws_iam_role" "glue_service" {
  name               = "GlueCICDServiceRole-${var.environment}"
  description        = "Role assumed by the Glue services to demonstrate the CI/CD Blueprint."
  assume_role_policy = data.aws_iam_policy_document.glue_service_trust.json
}

resource "aws_iam_role_policy_attachment" "glue_service_custom" {
  role       = aws_iam_role.glue_service.name
  policy_arn = aws_iam_policy.glue_service_custom.arn
}

resource "aws_iam_role_policy_attachment" "glue_service_trust" {
  role       = aws_iam_role.glue_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
