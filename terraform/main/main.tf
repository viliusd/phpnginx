terraform {
  required_version = "v0.13.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.8.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  shared_credentials_file = "credentials.sec"
}

provider "aws" {
  alias = "cloudfront"
  region = "us-east-1"
  shared_credentials_file = "credentials.sec"
}
