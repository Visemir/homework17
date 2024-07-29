terraform {
  backend "s3" {
    bucket = "terraform-state-danit-devops-2.2"
    key    = "kalinichenko.it/terraform.tfstate"
    region = "eu-central-1"
  }
}