output "rds_endpoint" {
    value = module.rds.rds_hostname
}

output "ec2_endpoint" {
    value = module.ec2_instance.instance_ip
}