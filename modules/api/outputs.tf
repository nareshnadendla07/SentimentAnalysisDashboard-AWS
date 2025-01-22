output "api_id" {
  description = "ID of the API Gateway"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_root_resource_id" {
  description = "Root resource ID of the API Gateway"
  value       = aws_api_gateway_rest_api.this.root_resource_id
}

output "stage_name" {
  description = "Name of the stage"
  value       = aws_api_gateway_stage.stage.stage_name
}

output "invoke_url" {
  description = "Invoke URL for the API Gateway"
  value       = aws_api_gateway_stage.stage.invoke_url
}
