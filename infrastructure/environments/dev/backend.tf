terraform {
  backend "s3" {
    bucket       = "fashsyst-tfstate-145888859267-us-east-2"
    key          = "environments/dev/terraform.tfstate"
    region       = "us-east-2"
    profile      = "fashsyst-dev"
    encrypt      = true
    use_lockfile = true
  }
}