data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "data" {
  bucket = var.data_bucket_id
}

data "aws_iam_policy_document" "athena_query_results_management" {
  statement {
    effect = "Allow"
    actions = [
      "athena:GetQueryExecution",
      "athena:GetQueryResults",
      "athena:GetQueryResultsStream",
      "athena:ListQueryExecutions",
      "athena:StartQueryExecution",
      "athena:StopQueryExecution"
    ]
    resources = [
      "*"
    ]
  }
  # =====================================================================================
  # DELETE THIS AND UNCOMMENT THE FOLLOWING STATEMENT TO ENABLE SSE-KMS ENCRYPTION IN
  # ATHENA AND S3.
  # =====================================================================================
  # statement {
  #   effect = "Allow"
  #   actions = [
  #     "kms:Decrypt",
  #     "kms:GenerateDataKey"
  #   ]
  #   resources = [
  #     aws_kms_key.athena_query_results.arn,
  #     var.s3_data_encryption_key_arn
  #   ]
  # }
  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.athena_query_results.arn,
      "${aws_s3_bucket.athena_query_results.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "athena_metadata_read_access" {
  statement {
    effect = "Allow"
    actions = [
      "athena:ListDataCatalogs"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "glue_catalog_read_access" {
  statement {
    effect = "Allow"
    actions = [
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetTable",
      "glue:GetTables"
    ]
    resources = [
      "${local.glue_resource_arn_prefix}:catalog",
      "${local.glue_resource_arn_prefix}:database/*"
    ]
  }
}

data "aws_iam_policy_document" "silver_tables_read_access" {
  statement {
    effect = "Allow"
    actions = [
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetPartition",
      "glue:GetPartitions"
    ]
    resources = [
      "${local.glue_resource_arn_prefix}:table/${var.silver_database_name}/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      data.aws_s3_bucket.data.arn
    ]
    condition {
      test     = "StringLike"
      values   = ["silver/*"]
      variable = "s3:prefix"
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${data.aws_s3_bucket.data.arn}/silver/*"
    ]
  }
}
