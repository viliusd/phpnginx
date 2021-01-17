provider "aws" {}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone
  tags = {
    Name = "${var.name}-subnet"
  }
}