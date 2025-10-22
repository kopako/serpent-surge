provider "aws" {
  region = var.aws_region
}

module "aws_bucket" {
  source = "./modules/s3"
}

module "ec2_instance" {
  source                   = "./modules/ec2"
  mount_target_bucket_name = module.aws_bucket.bucket_name
  file_system_path         = local.file_system_path
}

module "rds" {
  source      = "./modules/rds"
  db_password = var.db_password
}
