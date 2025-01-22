#######################
# Outputs
#######################
output "vpc_id" {
  value       = aws_vpc.this[0].id
  description = "The ID of the created VPC."
}

output "vpc_cidr_block" {
  value       = aws_vpc.this[0].cidr_block
  description = "The primary CIDR block of the VPC."
}

output "vpc_ipv6_cidr_block" {
  value       = aws_vpc.this[0].ipv6_cidr_block
  description = "The IPv6 CIDR block of the VPC (if assigned)."
}

output "secondary_cidr_blocks" {
  value       = var.secondary_cidr_blocks
  description = "The secondary CIDR blocks associated with the VPC."
}


output "dhcp_options_id" {
  value       = aws_vpc_dhcp_options.this[0].id
  description = "The ID of the DHCP options set"
  #condition   = var.enable_dhcp_options
}


output "vpc_flow_log_id" {
  value       = aws_flow_log.cloudwatch_logs.id
  description = "The ID of the VPC Flow Log"
}

output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.vpcflowlog_group.name
  description = "The name of the CloudWatch Log Group for VPC Flow Logs"
}

output "iam_role_arn" {
  value       = aws_iam_role.vpcflowlog_role.arn
  description = "The ARN of the IAM Role for VPC Flow Logs"
}
