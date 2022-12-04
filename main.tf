# AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.43.0"
    }
  }
  # Subtask 1
  # Backend Bucket
  backend "s3" {
    bucket = "upgrad-assignment-aryn"
    key    = "upgrad-assignment/tfstate"
    region = "us-east-1"
  }
}

# AWS Provider
provider "aws" {
  # Configuration options
  region = var.aws_region
  access_key = "AKIAZ6CKKQ6UUHFJVAFF"
  secret_key = "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"
}