module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.7.0"

  bucket = "${var.prefix}-devops-team-backend"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}