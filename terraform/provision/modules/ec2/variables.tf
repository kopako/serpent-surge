variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "serpent_surge"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t2.micro"
}

variable "ssh_keypair" {
  description = "The ssh key used by serpent surge ec2"
  default     = "aws_pki"
}

variable "file_system_path" {
  description = "Path to mount S3"
  type        = string
}

variable "mount_target_bucket_name" {
  description = "Mount Target S3 name"
  type        = string
}