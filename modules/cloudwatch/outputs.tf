output "log_group_name" {
  description = "Name of the created CloudWatch log group"
  value       = aws_cloudwatch_log_group.log_group[0].name
  
}

output "metric_filter_names" {
  description = "Names of created CloudWatch metric filters"
  value       = aws_cloudwatch_log_metric_filter.metric_filter.*.name
}

output "alarm_names" {
  description = "Names of created CloudWatch alarms"
  value       = aws_cloudwatch_metric_alarm.metric_alarm.*.alarm_name
}

output "dashboard_name" {
  description = "Name of the created CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.dashboard[0].dashboard_name
  
}
