output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group for the Lambda function"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}

output "s3_trigger_status" {
  description = "Whether S3 trigger is enabled"
  value       = var.enable_s3_trigger
}

output "dynamodb_trigger_status" {
  description = "Whether DynamoDB trigger is enabled"
  value       = var.enable_dynamodb_trigger
}
