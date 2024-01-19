resource "aws_glue_workflow" "us_legislators" {
  name        = "glue-ci-cd-us-legislators-${var.environment}"
  description = "Sample workflow for the AWS Glue CI/CD Blueprint."
}

resource "aws_glue_trigger" "us_legislators_bronze" {
  name          = "us-legislators-bronze-${var.environment}"
  type          = "ON_DEMAND"
  workflow_name = aws_glue_workflow.us_legislators.name

  actions {
    job_name = aws_glue_job.us_legislators["bronze"].name
  }
}

resource "aws_glue_trigger" "us_legislators_silver" {
  name          = "us-legislators-silver-${var.environment}"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.us_legislators.name

  predicate {
    conditions {
      job_name = aws_glue_job.us_legislators["bronze"].name
      state    = "SUCCEEDED"
    }
  }

  actions {
    job_name = aws_glue_job.us_legislators["silver"].name
  }
}

resource "aws_glue_trigger" "us_legislators_silver_crawler" {
  name          = "us-legislators-silver-crawler-${var.environment}"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.us_legislators.name

  predicate {
    conditions {
      job_name = aws_glue_job.us_legislators["silver"].name
      state    = "SUCCEEDED"
    }
  }

  actions {
    crawler_name = aws_glue_crawler.silver_us_legislators.name
  }
}
