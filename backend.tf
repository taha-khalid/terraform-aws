terraform {
  backend "s3" {
    bucket       = "taha-us-east1-terraform-state"
    key          = "devops/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
