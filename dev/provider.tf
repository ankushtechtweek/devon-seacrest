terraform {
  #backend "remote" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

    backend "s3" {
    bucket = var.s3_name
    key    = "devon-seacrest/terraform.tfstate"
    region = "us-east-1"
  }

}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
