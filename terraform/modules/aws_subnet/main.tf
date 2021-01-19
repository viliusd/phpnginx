provider "aws" {}

# resource "aws_vpc" "main" {
#   cidr_block = var.vpc_cidr_block
#   enable_dns_hostnames = true
#   tags = {
#     Name = "${var.name}-vpc"
#   }
# }

resource "aws_subnet" "public_green" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone
  tags = {
    Name = "${var.name}-subnet"
  }
}

resource "aws_subnet" "public_blue" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone2
  tags = {
    Name = "${var.name}-subnet"
  }
}

# resource "aws_internet_gateway" "gw" {
#   vpc_id = var.vpc_id

#   tags = {
#     Name = "${var.name}-gateway"
#   }
# }