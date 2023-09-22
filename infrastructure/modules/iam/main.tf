resource "aws_iam_role" "glue_service_role" {
  assume_role_policy = jsonencode({})
}
