# This KMS key is used to implement SSE-KMS in S3.
#
# Since January, 2023, AWS applies server-side encryption (SSE) with Amazon S3 managed
# keys (SSE-S3) as the base level of encryption for every bucket in S3. However, users
# can choose to configure buckets to use server-side encryption with AWS Key Management
# Service keys (SSE-KMS) instead. Please refer to
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingEncryption.html for details.
# =======================================================================================
# KMS KEYS ARE NOT CREATED BY DEFAULT TO AVOID EXTRA COSTS IN THE BLUEPRINT VALIDATION
# ACCOUNTS. DELETE THE LINES DELIMITED BY `# =...=` AND UNCOMMENT THE FOLLOWING RESOURCES
# TO CREATE/ENABLE THEM.
# =======================================================================================
# resource "aws_kms_key" "s3_data" {
#   description         = "Protects data tackled by the AWS Glue CI/CD Blueprint and stored in S3"
#   enable_key_rotation = true
# }

# resource "aws_kms_alias" "s3_data" {
#   name          = "alias/glue-ci-cd-blueprint/s3-data-${var.environment}"
#   target_key_id = aws_kms_key.s3_data.key_id
# }
