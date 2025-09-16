variable "vpc_cidr" {
  description = "The VPC CIDR block"
  type        = string
  default     = "10.0.0.0/18"
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "terraform vpc"
}
variable "subnet_cidr" {
  description = "The CIDR block of subnet"
  type        = string
  default     = "10.0.0.0/24"
}
variable "availability_zone" {
  description = "The availability zone of the VPC"
  type        = string
  default     = "eu-north-1a"
}
variable "subnet_name" {
  description = "The name of the subnet!"
  type        = string
  default     = "terra-sub-pub-1"
}
variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string
  default     = "mygw"
}
