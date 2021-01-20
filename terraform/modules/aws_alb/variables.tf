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

variable "ec2_aws_security_group_http" {
  type = string
  description = "ec2_aws_security_group_http"
}

variable "aws_lb_target_group_blue_arn" {
  type = string
  description = "aws_lb_target_group_blue_arn"
}

variable "aws_subnet_id" {
  type = list(string)
  description = "AWS Subnet ids"
}