output "instance_ip" {
  description = "Public IP name of the EC2 instance."
  value       = aws_instance.app_server.public_ip
}
