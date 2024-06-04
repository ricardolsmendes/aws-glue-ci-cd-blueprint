data "aws_s3_bucket" "data" {
  bucket = var.data_bucket_id
}

data "aws_iam_policy_document" "glue_service_custom" {
  # =====================================================================================
  # DELETE THIS AND UNCOMMENT THE FOLLOWING STATEMENT TO ENABLE SSE-KMS ENCRYPTION IN S3.
  # =====================================================================================
  # statement {
  #   effect = "Allow"
  #   actions = [
  #     "kms:Decrypt",
  #     "kms:GenerateDataKey"
  #   ]
  #   resources = [
  #     var.s3_data_encryption_key_arn
  #   ]
  # }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${data.aws_s3_bucket.data.arn}/*",
      "${aws_s3_bucket.glue["assets"].arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "glue_service_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}
