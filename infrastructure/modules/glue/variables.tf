variable "environment" {
  description = "The deployment environment."
  type        = string
  default     = "dev"
}

variable "data_bucket_id" {
  description = "ID of the S3 bucket used to store data."
  type        = string
  default     = ""
}

variable "glue_assets_bucket_name" {
  description = "Name of the S3 bucket used to store AWS Glue assets."
  type        = string
  default     = ""
}

variable "glue_scripts_bucket_name" {
  description = "Name of the S3 bucket used to store AWS Glue scripts."
  type        = string
  default     = ""
}
