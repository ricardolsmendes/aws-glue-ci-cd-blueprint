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

# =======================================================================================
# DELETE THIS AND UNCOMMENT THE FOLLOWING VARIABLE TO ENABLE SSE-KMS ENCRYPTION IN S3.
# =======================================================================================
# variable "s3_data_encryption_key_arn" {
#   description = "ARN of the KMS key that protects data tackled by the AWS Glue CI/CD Blueprint and stored in S3."
#   type        = string
#   default     = ""
# }

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
