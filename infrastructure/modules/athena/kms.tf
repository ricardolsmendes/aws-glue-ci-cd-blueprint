# This KMS key is used to implement SSE-KMS for Athena query results, improving the
# encryption at rest standards (https://docs.aws.amazon.com/athena/latest/ug/encryption.html
# for details). It is intended to be manually configured for the `primary` Athena
# Workgroup for now given we are not yet managing Workgroups through Terraform.
# =======================================================================================
# KMS KEYS ARE NOT CREATED BY DEFAULT TO AVOID EXTRA COSTS IN THE BLUEPRINT VALIDATION
# ACCOUNTS. DELETE THE LINES DELIMITED BY `# =...=` AND UNCOMMENT THE FOLLOWING RESOURCES
# TO CREATE/ENABLE THEM.
# =======================================================================================
# resource "aws_kms_key" "athena_query_results" {
#   description         = "Protects Athena query results tackled by the AWS Glue CI/CD Blueprint"
#   enable_key_rotation = true
# }

# resource "aws_kms_alias" "athena_query_results" {
#   name          = "alias/glue-ci-cd-blueprint/athena-query-results-${var.environment}"
#   target_key_id = aws_kms_key.athena_query_results.key_id
# }
