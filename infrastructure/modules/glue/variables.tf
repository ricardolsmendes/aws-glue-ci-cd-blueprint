variable "environment" {
  description = "The deployment environment."
  type        = string
  default     = "dev"
}

variable "default_tags" {
  description = "Default tags for the AWS resources."
  type        = map(string)
  default = {
    Project     = "AWS Glue CI/CD Blueprint"
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

variable "data_bucket_id" {
  description = "ID of the S3 bucket used to store data."
  type        = string
  default     = ""
}

variable "glue_scripts_bucket_id" {
  description = "ID of the S3 bucket used to store AWS Glue scripts."
  type        = string
  default     = ""
}

variable "glue_service_role_id" {
  description = "ID of the service role that will be attached to the AWS Glue jobs."
  type        = string
  default     = ""
}
