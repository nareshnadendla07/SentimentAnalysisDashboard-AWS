output "terraform_state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform state"
  value       = module.terraform_state_bucket.bucket_name
}

output "log_bucket_name" {
  description = "Name of the S3 bucket used for logs"
  value       = module.log_bucket.bucket_name
}

output "lock_table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  value       = module.terraform_state_lock_table.table_name
}

output "lock_table_stream_arn" {
  description = "Stream ARN of the DynamoDB table"
  value       = module.terraform_state_lock_table.stream_arn
}
