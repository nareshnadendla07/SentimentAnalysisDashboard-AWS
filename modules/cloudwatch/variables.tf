variable "create_log_group" {
  description = "Whether to create a CloudWatch log group"
  type        = bool
  default     = false
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = ""
}

variable "log_retention_in_days" {
  description = "Number of days to retain logs in the log group"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to associate with resources"
  type        = map(string)
  default     = {}
}

variable "create_metric_filter" {
  description = "Whether to create CloudWatch metric filters"
  type        = bool
  default     = false
}

variable "metric_filters" {
  description = "List of metric filters"
  type = list(object({
    name        = string
    pattern     = string
    metric_name = string
    namespace   = string
    value       = string
  }))
  default = []
}

variable "create_alarm" {
  description = "Whether to create CloudWatch alarms"
  type        = bool
  default     = false
}

variable "alarms" {
  description = "List of CloudWatch alarms"
  type = list(object({
    name                       = string
    metric_name                = string
    namespace                  = string
    comparison_operator        = string
    evaluation_periods         = number
    period                     = number
    statistic                  = string
    threshold                  = number
    actions_enabled            = bool
    alarm_actions              = optional(list(string))
    ok_actions                 = optional(list(string))
    insufficient_data_actions  = optional(list(string))
  }))
  default = []
}

variable "create_dashboard" {
  description = "Whether to create a CloudWatch dashboard"
  type        = bool
  default     = false
}

variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = ""
}

variable "dashboard_body" {
  description = "JSON body of the CloudWatch dashboard"
  type        = string
  default     = ""
}
