variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "api_description" {
  description = "Description of the API Gateway"
  type        = string
  default     = null
}

variable "stage_name" {
  description = "Stage name for the deployment"
  type        = string
  default     = "dev"
}

variable "api_resources" {
  description = "List of API resources with parent IDs and path parts"
  type = list(object({
    path_part = string
    parent_id = optional(string)
  }))
  default = []
}

variable "api_methods" {
  description = "Map of methods with HTTP method, authorization type, and integration settings"
  type = map(object({
    http_method             = string
    resource_id             = optional(string)
    authorization           = string
    api_key_required        = optional(bool)
    integration_type        = optional(string)
    integration_http_method = optional(string)
    uri                     = optional(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to associate with resources"
  type        = map(string)
  default     = {}
}
