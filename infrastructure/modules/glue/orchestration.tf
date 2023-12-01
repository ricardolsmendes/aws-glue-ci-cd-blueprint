resource "aws_glue_workflow" "us_legislators" {
  name        = "glue-ci-cd-us-legislators-${var.environment}"
  description = "Sample workflow for the AWS Glue CI/CD Blueprint."
  tags        = local.default_tags
}

resource "aws_glue_trigger" "bronze_us_legislators" {
  name          = "us-legislators-bronze-${var.environment}"
  type          = "ON_DEMAND"
  workflow_name = aws_glue_workflow.us_legislators.name
  tags          = local.default_tags
  actions {
    job_name = aws_glue_job.bronze_us_legislators.name
  }
}

resource "aws_glue_trigger" "silver_us_legislators" {
  name          = "us-legislators-silver-${var.environment}"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.us_legislators.name
  tags          = local.default_tags
  predicate {
    conditions {
      job_name = aws_glue_job.bronze_us_legislators.name
      state    = "SUCCEEDED"
    }
  }
  actions {
    job_name = aws_glue_job.silver_us_legislators.name
  }
}

resource "aws_glue_trigger" "silver_us_legislators_crawler" {
  name          = "us-legislators-silver-crawler-${var.environment}"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.us_legislators.name
  tags          = local.default_tags
  predicate {
    conditions {
      job_name = aws_glue_job.silver_us_legislators.name
      state    = "SUCCEEDED"
    }
  }
  actions {
    crawler_name = aws_glue_crawler.silver_us_legislators.name
  }
}
