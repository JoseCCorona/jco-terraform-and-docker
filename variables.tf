# Instance Type
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Defines the type of EC2 to be deploy"
}

# AMI
variable "ami" {
  type        = string
  default     = "ami-00ca32bbc84273381"
  description = "AMI to be used on ec2 deployment"
}

# Prefix
variable "prefix" {
  type        = string
  default     = "jco"
  description = "Prefix for resource naming convention"
}