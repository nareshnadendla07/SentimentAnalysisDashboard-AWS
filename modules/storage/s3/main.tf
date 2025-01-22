############
## S3 Bucket
############

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  #acl           = var.acl
  force_destroy = var.force_destroy

  tags = merge(
    {
      "Name" = var.bucket_name
    },
    var.tags
  )
}

#######################
## S3 Bucket Versioning
#######################


resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

###################################
## S3 Bucket Server Side Encryption
###################################

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = var.enable_encryption ? 1 : 0

  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption_algorithm
      kms_master_key_id = var.encryption_algorithm == "aws:kms" ? var.kms_key_id : null
    }
  }
}

####################################
## S3 Bucket Lifecycle Configuration
####################################

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count = var.enable_lifecycle_rules ? 1 : 0

  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      filter {
        prefix = lookup(rule.value, "prefix", null)
      }

      expiration {
        days = lookup(rule.value, "expiration_days", null)
      }

      transition {
        days          = lookup(rule.value, "transition_days", null)
        storage_class = lookup(rule.value, "storage_class", null)
      }
    }
  }
}

###################
## S3 Bucket Policy
###################

resource "aws_s3_bucket_policy" "this" {
  count = var.enable_bucket_policy ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
}

################################
## S3 Bucket Public Access Block
################################

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = var.bucket_name
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

##############################
## S3 Bucket Ownership Control
##############################

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = var.bucket_name

  rule {
    object_ownership = var.object_ownership
  }
}

################
## S3 Bucket Acl
################

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]
  bucket     = var.bucket_name
  acl        = var.bucket_acl
}
