#######################
# Local Variables
#######################
variable "create_vpc" {
  description = "Whether to create the VPC or use an existing one"
  type        = bool
  default     = true
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "The instance tenancy for the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_ipv6" {
  description = "Whether to enable IPv6 in the VPC"
  type        = bool
  default     = false
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC"
  type        = list(string)
  default     = []
}

variable "enable_dhcp_options" {
  description = "Whether to create and associate a DHCP options set"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "The domain name for the DHCP options set"
  type        = string
  default     = null
}

variable "dhcp_options_domain_name_servers" {
  description = "A list of domain name servers for the DHCP options set"
  type        = list(string)
  default     = []
}

variable "dhcp_options_ntp_servers" {
  description = "A list of NTP servers for the DHCP options set"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "A list of NetBIOS name servers for the DHCP options set"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "The NetBIOS node type for the DHCP options set"
  type        = number
  default     = null
}

variable "name" {
  description = "The name of the VPC"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags specific to the VPC"
  type        = map(string)
  default     = {}
}

variable "dhcp_options_tags" {
  description = "Additional tags specific to the DHCP options set"
  type        = map(string)
  default     = {}
}

variable "log_retention_in_days" {
  description = "Number of days to retain logs in CloudWatch"
  type        = number
  default     = 90
}