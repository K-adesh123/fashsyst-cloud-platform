provider "aws" {
  region              = "us-east-2"
  profile             = "fashsyst-dev"
  allowed_account_ids = ["145888859267"]

  default_tags {
    tags = {
      Project     = "fashsyst-cloud-platform"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  description = "AWS account used by Terraform."
  value       = data.aws_caller_identity.current.account_id
}