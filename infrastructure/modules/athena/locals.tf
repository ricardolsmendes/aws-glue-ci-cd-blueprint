locals {
  glue_resource_arn_prefix = "arn:aws:glue:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"
}
