output "security_group_id" {
  value       = aws_security_group.this[0].id
  description = "The ID of the created security group"
}

output "security_group_name" {
  value       = aws_security_group.this[0].name
  description = "The name of the created security group"
}
