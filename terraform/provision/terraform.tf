terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.10.0"
    }
  }

  backend "s3" {
    bucket = "serpent-surge-s3"
    key    = "network/terraform.tfstate"
    region = "eu-central-1"
  }

  required_version = ">= 1.2"
}
