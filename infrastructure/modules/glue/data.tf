data "aws_s3_bucket" "data" {
  bucket = var.data_bucket_id
}

data "aws_iam_policy_document" "glue_service_custom" {
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
      "${aws_s3_bucket.glue_assets.arn}/*"
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
