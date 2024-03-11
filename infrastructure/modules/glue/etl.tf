resource "aws_glue_job" "us_legislators" {
  for_each = local.us_legislators_jobs_map

  name              = each.value.name
  description       = each.value.description
  role_arn          = aws_iam_role.glue_service_custom.arn
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = 2
  execution_class   = "FLEX"
  default_arguments = each.value.default_arguments

  command {
    script_location = each.value.script_location
  }
}
