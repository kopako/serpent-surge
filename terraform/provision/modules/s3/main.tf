resource "aws_s3_bucket" "serpent_surge_backup_bucket" {
  bucket = var.bucket_name
}
