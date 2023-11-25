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

variable "sample_bronze_job_name" {
  description = "Name of the Glue job used to demonstrate data ingestion into the Bronze layer."
  type        = string
  default     = ""
}

variable "sample_silver_job_name" {
  description = "Name of the Glue job used to demonstrate data ingestion into the Silver layer."
  type        = string
  default     = ""
}
