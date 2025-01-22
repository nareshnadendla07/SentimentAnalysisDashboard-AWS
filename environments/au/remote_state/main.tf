locals {
  unique_prefix = lower("${var.customer}-${var.application}-${var.environment}")
}


module "terraform_state_bucket" {
  source = "../../../modules/storage/s3"

  bucket_name          = "${local.unique_prefix}-tfstate-bucket"
  acl                  = "private"
  force_destroy        = true
  versioning_enabled   = true
  enable_encryption    = true
  encryption_algorithm = "AES256"

  object_ownership = "BucketOwnerPreferred"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  enable_lifecycle_rules = true
  lifecycle_rules = [
    {
      id              = "delete-old-logs-after-30-days"
      status          = "Enabled"
      prefix          = "logs/"
      expiration_days = 30
    },
    {
      id              = "transition-to-infrequent-access"
      status          = "Enabled"
      prefix          = "data/"
      transition_days = 60
      storage_class   = "STANDARD_IA"
    }
  ]

  enable_bucket_policy = true
  bucket_policy        = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${local.unique_prefix}-tfstate-bucket/*"
    }
  ]
}
POLICY

  tags = merge(
    {
      "Name"        = "${local.unique_prefix}-tfstate-bucket"
      "Environment" = var.environment
      "Project"     = var.application
      "Customer"    = var.customer
    },
    var.tags
  )
}


module "log_bucket" {
  source = "../../../modules/storage/s3"

  bucket_name          = "${local.unique_prefix}-tfstate-bucket-logs"
  acl                  = "private"
  force_destroy        = true
  versioning_enabled   = true
  enable_encryption    = true
  encryption_algorithm = "AES256"

  object_ownership = "BucketOwnerPreferred"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true


  enable_lifecycle_rules = true
  lifecycle_rules = [
    {
      id              = "delete-old-logs-after-30-days"
      status          = "Enabled"
      prefix          = "logs/"
      expiration_days = 30
    },
    {
      id              = "transition-to-infrequent-access"
      status          = "Enabled"
      prefix          = "data/"
      transition_days = 60
      storage_class   = "STANDARD_IA"
    }
  ]

  enable_bucket_policy = true
  bucket_policy        = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${local.unique_prefix}-tfstate-bucket-logs/*"
    }
  ]
}
POLICY

  tags = merge(
    {
      "Name"        = "${local.unique_prefix}-tfstate-bucket-logs"
      "Environment" = var.environment
      "Project"     = var.application
      "Customer"    = var.customer
    },
    var.tags
  )
}

######################################################################
## Use a DynamoDB table as a locking mechanism for the Terraform state
######################################################################

module "terraform_state_lock_table" {
  source = "../../../modules/dynamodb"

  table_name       = "${local.unique_prefix}-tfstate-lock-table"
  hash_key         = "LockID"
  hash_key_type    = "S"
  range_key        = "timestamp"
  range_key_type   = "N"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  enable_ttl       = true
  ttl_attribute    = "ttl"

  # Autoscaling Configuration
  enable_autoscaling             = true
  read_capacity                  = 1
  write_capacity                 = 1
  read_autoscaling_min_capacity  = 1
  read_autoscaling_max_capacity  = 10 # Adjust based on expected workload
  write_autoscaling_min_capacity = 1
  write_autoscaling_max_capacity = 10 # Adjust based on expected workload

  tags = merge(
    {
      "Name"        = "${local.unique_prefix}-tfstate-lock-table"
      "Environment" = var.environment
      "Project"     = var.application
      "Customer"    = var.customer
    },
    var.tags
  )
}

#####################################################
## Create the backend_config.tfvars file for this env
#####################################################

resource "local_file" "backend_config" {
  filename        = "${path.module}/../${var.environment}_backend_config.tfvars"
  file_permission = "0644"
  content = templatefile("${path.module}/backend_config.tfvars.tmpl",
    {
      Region      = var.region
      Bucket-Key  = "${local.unique_prefix}.tfstate"
      Bucket-Name = module.terraform_state_bucket.bucket_name
      DDB-Table   = module.terraform_state_lock_table.table_name
    }
  )
}
