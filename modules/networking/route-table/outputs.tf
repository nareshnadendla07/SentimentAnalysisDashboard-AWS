###############
## Outputs
###############
output "route_table_ids" {
  value       = aws_route_table.route_tables[*].id
  description = "List of route table IDs"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "ID of the Internet Gateway"
}
