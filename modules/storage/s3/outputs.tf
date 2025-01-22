output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_region" {
  description = "The region of the S3 bucket"
  value       = aws_s3_bucket.this.region
}

output "public_access_block_id" {
  description = "The ID of the public access block configuration"
  value       = aws_s3_bucket_public_access_block.this.id
}

output "bucket_ownership_controls_id" {
  description = "The ID of the S3 bucket ownership controls"
  value       = aws_s3_bucket_ownership_controls.this.id
}

output "bucket_acl" {
  description = "The ACL applied to the bucket"
  value       = aws_s3_bucket_acl.this.acl
}
