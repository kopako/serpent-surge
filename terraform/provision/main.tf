provider "aws" {
  region = var.aws_region
}

module "aws_vpc" {
  source = "./modules/vpc"
}

module "aws_bucket" {
  source = "./modules/s3"
}

module "ec2_instance" {
  source = "./modules/ec2"
}

module "rds" {
  source      = "./modules/rds"
  db_password = var.db_password
}
