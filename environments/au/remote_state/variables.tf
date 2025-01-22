variable "customer" {
  type        = string
  description = "A unique identifier to differentiate this deployment."
}

variable "application" {
  type        = string
  description = "A unique identifier to differentiate this deployment."
}

variable "region" {
  type        = string
  description = "The region in which to deploy the remote backend resources."
}

variable "environment" {
  type        = string
  description = "Environment name, such as 'dev', 'Test', or 'Production'"
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket on deletion"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}