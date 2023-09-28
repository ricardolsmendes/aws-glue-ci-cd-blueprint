variable "environment" {
  description = "The deployment environment."
  type        = string
  default     = "dev"
}

variable "glue_scripts_bucket_name" {
  description = "Name of the S3 bucket used to store AWS Glue scripts."
  type        = string
  default     = "aws-glue-ci-cd-blueprint-glue-scripts"
}

variable "sample_spark_job_name" {
  description = "Name of the Glue job used to demonstrate Spark features."
  type        = string
  default     = "aws-glue-ci-cd-blueprint-sample-spark-job"
}
