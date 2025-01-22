variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode of the table (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "Read capacity for the DynamoDB table"
  type        = string

}

variable "write_capacity" {
  description = "write capacity for the DynamoDB table"
  type        = string

}

variable "hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
}

variable "hash_key_type" {
  description = "Hash key type (S for String, N for Number, B for Binary)"
  type        = string
}

variable "range_key" {
  description = "Optional range key for the DynamoDB table"
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "Range key type (S for String, N for Number, B for Binary)"
  type        = string
  default     = null
}

variable "stream_enabled" {
  description = "Whether to enable streams on the table"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Stream view type (NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES, KEYS_ONLY)"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}

variable "global_secondary_indexes" {
  description = "List of global secondary indexes"
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = optional(string)
    projection_type    = string
    non_key_attributes = optional(list(string))
    read_capacity      = optional(number)
    write_capacity     = optional(number)
  }))
  default = []
}

variable "enable_ttl" {
  description = "Whether to enable TTL on the table"
  type        = bool
  default     = false
}

variable "ttl_attribute" {
  description = "TTL attribute name"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the table"
  type        = map(string)
  default     = {}
}

variable "enable_autoscaling" {
  description = "Whether to enable auto-scaling for read/write capacity"
  type        = bool
  default     = false
}

variable "read_autoscaling_min_capacity" {
  description = "Minimum read capacity for auto-scaling"
  type        = number
  default     = 1
}

variable "read_autoscaling_max_capacity" {
  description = "Maximum read capacity for auto-scaling"
  type        = number
  default     = 100
}

variable "read_autoscaling_target_value" {
  description = "Target utilization for read capacity auto-scaling"
  type        = number
  default     = 70
}

variable "read_autoscaling_scale_in_cooldown" {
  description = "Cooldown period before scale-in"
  type        = number
  default     = 60
}

variable "read_autoscaling_scale_out_cooldown" {
  description = "Cooldown period before scale-out"
  type        = number
  default     = 60
}

variable "write_autoscaling_min_capacity" {
  description = "Minimum write capacity for auto-scaling"
  type        = number
  default     = 1
}

variable "write_autoscaling_max_capacity" {
  description = "Maximum write capacity for auto-scaling"
  type        = number
  default     = 100
}

variable "write_autoscaling_target_value" {
  description = "Target utilization for write capacity auto-scaling"
  type        = number
  default     = 70
}

variable "write_autoscaling_scale_in_cooldown" {
  description = "Cooldown period before scale-in"
  type        = number
  default     = 60
}

variable "write_autoscaling_scale_out_cooldown" {
  description = "Cooldown period before scale-out"
  type        = number
  default     = 60
}
