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

module "sg_http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${var.prefix}-http-sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["187.200.117.93/32"]
  egress_rules = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  name = "${var.prefix}-task1-instance"
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [module.sg_http.security_group_id]
  subnet_id              = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true
  user_data     = file("docker-nginx.sh")
}