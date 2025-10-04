output "instance_01_public_ip" {
  value = module.ec2_instance.jco_ec2_public_ip
}

output "instance_02_public_ip" {
  value = module.ec2_instance_2.jco_ec2_public_ip
}