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

variable "data_bucket_name" {
  description = "Name of the S3 bucket used to store data."
  type        = string
  default     = "glue-ci-cd-data"
}

variable "glue_assets_bucket_name" {
  description = "Name of the S3 bucket used to store AWS Glue assets."
  type        = string
  default     = "glue-ci-cd-assets"
}

variable "glue_scripts_bucket_name" {
  description = "Name of the S3 bucket used to store AWS Glue scripts."
  type        = string
  default     = "glue-ci-cd-scripts"
}

variable "athena_query_results_bucket_name" {
  description = "Name of the S3 bucket used to store Athena query results."
  type        = string
  default     = "glue-ci-cd-athena-query-results"
}
