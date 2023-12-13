variable "environment" {
  description = "The deployment environment."
  type        = string
  default     = "dev"
}

variable "athena_query_results_bucket_name" {
  description = "Name of the S3 bucket used to store Athena query results."
  type        = string
  default     = ""
}

variable "data_bucket_id" {
  description = "ID of the S3 bucket used to store data."
  type        = string
  default     = ""
}

variable "silver_database_name" {
  description = "Name of the Glue database used to catalog data in the Silver layer."
  type        = string
  default     = ""
}
