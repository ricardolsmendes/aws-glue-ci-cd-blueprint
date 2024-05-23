# Since January, 2023, AWS applies server-side encryption with Amazon S3 managed keys
# (SSE-S3) as the base level of encryption for every bucket in S3. However, users can
# choose to configure buckets to use server-side encryption with AWS Key Management
# Service (KMS) keys (SSE-KMS) instead. This KMS key is used to implement SSE-KMS.
# Please refer to https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingEncryption.html
# for further details.
resource "aws_kms_key" "s3" {
  description         = "This key that protects S3 objects tackled by the AWS Glue CI/CD Blueprint"
  enable_key_rotation = true
}

resource "aws_kms_alias" "s3" {
  name          = "alias/glue-ci-cd-blueprint/s3-${var.environment}"
  target_key_id = aws_kms_key.s3.key_id
}
