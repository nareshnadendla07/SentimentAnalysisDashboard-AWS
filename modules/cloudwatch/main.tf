#######################
## CloudWatch Log Group
#######################

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.create_log_group ? 1 : 0
  name              = var.log_group_name
  retention_in_days = var.log_retention_in_days

  tags = var.tags
}

###########################
## CloudWatch Metric Filter
###########################

resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  count          = var.create_metric_filter ? length(var.metric_filters) : 0
  name           = element(var.metric_filters[count.index].name, 0)
  log_group_name = aws_cloudwatch_log_group.log_group[0].name
  pattern        = element(var.metric_filters[count.index].pattern, 0)

  metric_transformation {
    name      = element(var.metric_filters[count.index].metric_name, 0)
    namespace = element(var.metric_filters[count.index].namespace, 0)
    value     = element(var.metric_filters[count.index].value, 0)
  }
}

###################
## CloudWatch Alarm
###################

resource "aws_cloudwatch_metric_alarm" "metric_alarm" {
  count                     = var.create_alarm ? length(var.alarms) : 0
  alarm_name                = element(var.alarms[count.index].name, 0)
  comparison_operator       = element(var.alarms[count.index].comparison_operator, 0)
  evaluation_periods        = element(var.alarms[count.index].evaluation_periods, 0)
  metric_name               = element(var.alarms[count.index].metric_name, 0)
  namespace                 = element(var.alarms[count.index].namespace, 0)
  period                    = element(var.alarms[count.index].period, 0)
  statistic                 = element(var.alarms[count.index].statistic, 0)
  threshold                 = element(var.alarms[count.index].threshold, 0)
  actions_enabled           = element(var.alarms[count.index].actions_enabled, 0)
  alarm_actions             = lookup(var.alarms[count.index], "alarm_actions", [])
  ok_actions                = lookup(var.alarms[count.index], "ok_actions", [])
  insufficient_data_actions = lookup(var.alarms[count.index], "insufficient_data_actions", [])
}

#######################
## CloudWatch Dashboard
#######################

resource "aws_cloudwatch_dashboard" "dashboard" {
  count          = var.create_dashboard ? 1 : 0
  dashboard_name = var.dashboard_name
  dashboard_body = var.dashboard_body
}
