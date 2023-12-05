resource "aws_glue_catalog_database" "silver" {
  name         = "glue_ci_cd_silver_${var.environment}"
  description  = "Database for the AWS Glue CI/CD Blueprint (Silver layer)"
  location_uri = "s3://${var.data_bucket_id}/silver"
  tags         = local.default_tags
}

resource "aws_glue_crawler" "silver_us_legislators" {
  name          = "glue-ci-cd-silver-us-legislators-${var.environment}"
  description   = "Crawler for the US Legislators table (AWS Glue CI/CD Blueprint, Silver layer)"
  database_name = aws_glue_catalog_database.silver.name
  role          = aws_iam_role.glue_service.arn
  tags          = local.default_tags
  s3_target {
    path = "s3://${var.data_bucket_id}/silver/us-legislators"
  }
}
