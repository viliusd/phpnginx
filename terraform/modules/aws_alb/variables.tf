variable "name" {
  description = "Name"
  type = string
  validation {
    condition = length(var.name) >= 1 && length(var.name) <= 60 && !can(regex("[^A-Za-z0-9. -]", var.name))
    error_message = "1. Name length should be between 1 and 60 characters.\n2. Name should consist only of alphanumeric characters, dots, spaces and dashes."
  }
}

variable "aws_vpc_id" {
  type = string
  description = "AWS VPC id"
}

variable "cidr_block" {
  type = string
  description = "VPC main cidr_block"
}

variable "ec2_aws_security_group" {
  type = string
  description = "ec2_aws_security_group"
}

variable "aws_subnet_id" {
  type = list(string)
  description = "aws_subnet_id"
}

variable "aws_instance_id" {
  type = string
  description = "aws_instance_id"
}