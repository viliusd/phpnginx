variable "env_name" {
  description = "Environment name"
  type = string
  validation {
    condition = var.env_name == "" || (length(var.env_name) >= 1 && length(var.env_name) <= 15 && !can(regex("[^A-Za-z0-9. -]", var.env_name)))
    error_message = "1. Environment name length should be between 1 and 15 characters.\n2. Environment name should consist only of alphanumeric characters, dots, spaces and dashes."
  }
  default = ""
}

variable "name" {
  description = "Name"
  type = string
  validation {
    condition = length(var.name) >= 1 && length(var.name) <= 60 && !can(regex("[^A-Za-z0-9. -]", var.name))
    error_message = "1. Name length should be between 1 and 60 characters.\n2. Name should consist only of alphanumeric characters, dots, spaces and dashes."
  }
}

variable "instance_ami_id" {
  type = string
  description = "EC2 instance AMI id ami-0ff4c8fb495a5a50d (Ubuntu)"
}

variable "instance_type" {
  type = string
  description = "EC2 instance type for example t2.micro"
}

variable "aws_subnet_id" {
  type = string
  description = "AWS Subnet id"
}

variable "tag_name" {
  type = string
  description = "EC2 instance tag name"
}

variable "aws_vpc_id" {
  type = string
  description = "AWS VPC id"
}

variable "ingress_cidr_block" {
  type = list(string)
  description = "list of IP allowed for incoming connections"
}