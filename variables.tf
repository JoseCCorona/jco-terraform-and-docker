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

# Ingress CIDR Block
variable "ingress_cidr_blocks" {
  type        = string
  description = "Ingress CIDR Block"
}

# SG Ingress port
variable "ingress_port" {
  type        = number
  default     = "80"
  description = "Ingress port for SG"
}

# SG Ingress protocol
variable "ingress_protocol" {
  type        = string
  default     = "tcp"
  description = "Ingress protocol for SG"
}

# Instance Role
variable "instance_role" {
  type        = string
  default     = "null"
  description = "Role to be attached to EC2"
}

# EC2 Name Identifier
variable "ec2_identifier"{
  type        = string
  default = "02"
  description = "Identifier for EC2 name"
} 