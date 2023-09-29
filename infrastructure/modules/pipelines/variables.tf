variable "environment" {
  description = "The deployment environment."
  type        = string
  default     = "dev"
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

variable "sample_spark_job_name" {
  description = "Name of the Glue job used to demonstrate Spark features."
  type        = string
  default     = "aws-glue-ci-cd-blueprint-sample-spark-job"
}
