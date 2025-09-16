variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "serpent-surge"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t2.micro"
}

variable "ssh_keypair" {
    description = "The ssh key used by serpent surge ec2"
    default = "aws_pki"
}