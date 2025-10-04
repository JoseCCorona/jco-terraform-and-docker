module "s3_bucket" {
  source = "github.com/JoseCCorona/terraform-s3-module"

  bucket_name = "${var.prefix}-devops-team-backend"
}