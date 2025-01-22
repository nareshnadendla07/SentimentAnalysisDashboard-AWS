# Input variables
variable "subnets" {
  description = "A list of subnet configurations with CIDR, availability zone, and other attributes"
  type = list(object({
    cidr_block     = string
    az             = string
    name           = optional(string, null) # Optional subnet name
    map_public_ip  = optional(bool, false)  # Optional public IP mapping
  }))
  default = []
}

variable "vpc_id" {
  description = "The ID of the VPC where the subnets will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}