variable "aws_access_key" {
  description = "The AWS access key."
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_secret_key" {
  description = "The AWS secret key."
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_region" {
  description = "The AWS region."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The deployment environment."
  type        = string
  default     = "prod"
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
