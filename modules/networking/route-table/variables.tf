###############
## Variables
###############
variable "subnets" {
  description = "List of subnets to associate with route tables"
  type = list(object({
    id      = string  # Subnet ID
    cidr    = string  # Subnet CIDR (optional for context)
    public  = bool    # Whether the subnet is public or private
  }))
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "client_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}