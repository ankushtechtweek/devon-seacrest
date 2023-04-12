terraform {
  backend "remote" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

     backend "s3" {
    key    = "modules/terraform.tfstate"
    region = ""
  }

}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

data "terraform_remote_state" "dev" {
  backend = "remote"

  config = {
    organization = ""
    workspaces = {
      name = ""
    }
  }
}
