variable "db_password" {
  sensitive = true
  ephemeral = true
}

variable "aws_region" {
  default = "eu-central-1"
}
