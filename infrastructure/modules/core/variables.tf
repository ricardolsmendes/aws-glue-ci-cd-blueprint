variable "environment" {
  description = "The deployment environment."
  type        = string
  default     = "dev"
}

variable "data_bucket_name" {
  description = "Name of the S3 bucket used to store data."
  type        = string
  default     = ""
}
