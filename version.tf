terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
  }
}

provider "aws" {
  # Configuration 
  # access_key = var.access_key
  # secret_key = var.secret_key
  # region     = var.region

}