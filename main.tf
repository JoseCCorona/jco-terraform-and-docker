# S3 backend
terraform {
  backend "s3" {
    bucket  = "jco-devops-team-backend"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "terraform-role"
  }
}

module "ec2_instance" {
  source = "github.com/JoseCCorona/terraform-ec2-module"

  ami                 = var.ami
  instance_type       = var.instance_type
  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_port        = var.ingress_port
  ingress_protocol    = var.ingress_protocol
  instance_role       = var.instance_role

  user_data      = file("docker-nginx.sh")
  ssh_public_key = file("~/.ssh/jco-key.pub")
}

module "s3_bucket" {
  source = "github.com/JoseCCorona/terraform-s3-module"

  bucket_name = "jco-task2"
}

module "ec2_instance_2" {
  source = "github.com/JoseCCorona/terraform-ec2-module"

  depends_on = [module.ec2_instance,module.s3_bucket]

  ec2_identifier      = var.ec2_identifier
  ami                 = var.ami
  instance_type       = var.instance_type
  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_port        = var.ingress_port
  ingress_protocol    = var.ingress_protocol
  instance_role       = var.instance_role

  user_data      = file("docker-s3.sh")
  ssh_public_key = file("~/.ssh/jco-key.pub")
}