variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime for the Lambda function (e.g., python3.9, nodejs14.x)"
  type        = string
}

variable "handler" {
  description = "Handler for the Lambda function"
  type        = string
}

variable "source_path" {
  description = "Path to the Lambda function source code (ZIP file)"
  type        = string
}

variable "timeout" {
  description = "Timeout for the Lambda function"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Memory size for the Lambda function"
  type        = number
  default     = 128
}

variable "publish" {
  description = "Whether to publish a new version of the function"
  type        = bool
  default     = false
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to associate with resources"
  type        = map(string)
  default     = {}
}

variable "log_retention_in_days" {
  description = "Retention period for CloudWatch logs"
  type        = number
  default     = 7
}

variable "lambda_policy" {
  description = "IAM policy for the Lambda function"
  type        = string
}

# API Gateway Trigger
variable "enable_api_gateway_trigger" {
  description = "Whether to enable API Gateway trigger"
  type        = bool
  default     = false
}

# S3 Trigger
variable "enable_s3_trigger" {
  description = "Whether to enable S3 event trigger"
  type        = bool
  default     = false
}

variable "s3_bucket_name" {
  description = "S3 bucket name for the trigger"
  type        = string
  default     = null
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  type        = string
  default     = null
}

variable "s3_events" {
  description = "List of S3 events to trigger the Lambda function"
  type        = list(string)
  default     = ["s3:ObjectCreated:*"]
}

variable "s3_filter_prefix" {
  description = "S3 filter prefix for event trigger"
  type        = string
  default     = null
}

variable "s3_filter_suffix" {
  description = "S3 filter suffix for event trigger"
  type        = string
  default     = null
}

# DynamoDB Trigger
variable "enable_dynamodb_trigger" {
  description = "Whether to enable DynamoDB stream trigger"
  type        = bool
  default     = false
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  type        = string
  default     = null
}

variable "dynamodb_stream_arn" {
  description = "ARN of the DynamoDB stream"
  type        = string
  default     = null
}

variable "dynamodb_starting_position" {
  description = "Starting position for DynamoDB stream"
  type        = string
  default     = "LATEST"
}

variable "dynamodb_batch_size" {
  description = "Batch size for DynamoDB stream events"
  type        = number
  default     = 100
}
