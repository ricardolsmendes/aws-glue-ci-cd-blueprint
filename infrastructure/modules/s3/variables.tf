variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "dev"
}

variable "data_bucket_name" {
  description = "Name of the S3 bucket used to store data"
  type        = string
  default     = "aws-glue-ci-cd-blueprint-data"
}

variable "glue_assets_bucket_name" {
  description = "Name of the S3 bucket used to store AWS Glue assets"
  type        = string
  default     = "aws-glue-ci-cd-blueprint-glue-assets"
}

variable "glue_scripts_bucket_name" {
  description = "Name of the S3 bucket used to store AWS Glue scripts"
  type        = string
  default     = "aws-glue-ci-cd-blueprint-glue-scripts"
}
