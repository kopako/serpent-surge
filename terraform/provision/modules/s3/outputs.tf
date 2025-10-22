output "bucket_name" {
  value = aws_s3_bucket.serpent_surge_backup_bucket.bucket
}
output "bucket_arn" {
  value = aws_s3_bucket.serpent_surge_backup_bucket.arn
}
