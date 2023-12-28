locals {
  default_tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
    CreatedBy   = "Terraform"
  }

  buckets_map = {
    assets = {
      name = "${var.glue_assets_bucket_name}-${var.environment}"
    },
    scripts = {
      name = "${var.glue_scripts_bucket_name}-${var.environment}"
    }
  }

  us_legislators_jobs_map = {
    bronze = {
      name        = "glue-ci-cd-bronze-us-legislators-${var.environment}"
      description = "Sample Bronze-layer job for the AWS Glue CI/CD Blueprint."
      default_arguments = {
        "--source-bucket-name" = "awsglue-datasets",
        "--source-file-path"   = "examples/us-legislators/all/persons.json",
        "--target-bucket-name" = var.data_bucket_id,
        "--target-file-path"   = "bronze/awsglue-datasets/us-legislators/all-persons.json",
      },
      script_location = "s3://${aws_s3_bucket.glue["scripts"].id}/s3_to_s3_job.py"
    },
    silver = {
      name        = "glue-ci-cd-silver-us-legislators-${var.environment}"
      description = "Sample Silver-layer job for the AWS Glue CI/CD Blueprint."
      default_arguments = {
        "--source-bucket-name" = var.data_bucket_id,
        "--source-file-path"   = "bronze/awsglue-datasets/us-legislators/all-persons.json",
        "--target-bucket-name" = var.data_bucket_id,
        "--target-table-path"  = "silver/us-legislators",
      },
      script_location = "s3://${aws_s3_bucket.glue["scripts"].id}/s3_json_to_parquet_job.py"
    }
  }
}
