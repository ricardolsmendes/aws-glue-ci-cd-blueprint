resource "aws_glue_catalog_database" "silver" {
  name         = "aws_glue_ci_cd_blueprint_silver_${var.environment}"
  description  = "Database for the AWS Glue CI/CD Blueprint (Silver layer)"
  location_uri = "${var.data_bucket_id}/silver"
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
}

resource "aws_glue_crawler" "silver_us_legislators" {
  name          = "aws-glue-ci-cd-blueprint-silver-us-legislators-${var.environment}"
  description   = "Crawler for the US Legislators table (AWS Glue CI/CD Blueprint, Silver layer)"
  database_name = aws_glue_catalog_database.silver.name
  role          = data.aws_iam_role.glue_service.arn
  tags = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
  }
  s3_target {
    path = "s3://${var.data_bucket_id}/silver/us-legislators"
  }
}
