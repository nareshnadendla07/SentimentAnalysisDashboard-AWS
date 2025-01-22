variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "The ACL for the bucket (e.g., private, public-read)"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket on deletion"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Encryption algorithm to use (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "The KMS key ID to use for encryption (required if encryption_algorithm is aws:kms)"
  type        = string
  default     = null
}

variable "enable_lifecycle_rules" {
  description = "Enable lifecycle rules for the bucket"
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "A list of lifecycle rules to apply to the bucket"
  type = list(object({
    id              = string
    status          = string
    prefix          = optional(string)
    expiration_days = optional(number)
    transition_days = optional(number)
    storage_class   = optional(string)
  }))
  default = []
}

variable "enable_bucket_policy" {
  description = "Enable bucket policy"
  type        = bool
  default     = false
}

variable "bucket_policy" {
  description = "The JSON bucket policy"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for the bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for the bucket"
  type        = bool
  default     = true
}

variable "object_ownership" {
  description = "The object ownership setting for the bucket"
  type        = string
  default     = "BucketOwnerPreferred"
}

variable "bucket_acl" {
  description = "The ACL to apply to the bucket"
  type        = string
  default     = "private"
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
