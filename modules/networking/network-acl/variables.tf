variable "manage_default_network_acl" {
  description = "Whether to manage the default network ACL"
  type        = bool
  default     = true
}

variable "default_network_acl_id" {
  description = "The ID of the default network ACL"
  type        = string
}

variable "default_network_acl_ingress" {
  description = "List of ingress rules for the default network ACL"
  type = list(object({
    action          = string
    cidr_block      = optional(string, null)
    from_port       = number
    icmp_code       = optional(number, null)
    icmp_type       = optional(number, null)
    ipv6_cidr_block = optional(string, null)
    protocol        = string
    rule_no         = number
    to_port         = number
  }))
  default = []
}

variable "default_network_acl_egress" {
  description = "List of egress rules for the default network ACL"
  type = list(object({
    action          = string
    cidr_block      = optional(string, null)
    from_port       = number
    icmp_code       = optional(number, null)
    icmp_type       = optional(number, null)
    ipv6_cidr_block = optional(string, null)
    protocol        = string
    rule_no         = number
    to_port         = number
  }))
  default = []
}

variable "default_network_acl_name" {
  description = "Name for the default network ACL"
  type        = string
  default     = "Default Network ACL"
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "default_network_acl_tags" {
  description = "Additional tags specific to the default network ACL"
  type        = map(string)
  default     = {}
}
