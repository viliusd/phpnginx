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


resource "aws_default_vpc" "default" {
  # (resource arguments)
}

#COMMANDS TO be executed prior deployment
#aws ec2 create-default-vpc --region eu-west-2
#terraform import aws_default_vpc.default vpc-03871b6fb7b916cdf