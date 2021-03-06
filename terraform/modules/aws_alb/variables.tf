variable "name" {
  description = "Name"
  type = string
  validation {
    condition = length(var.name) >= 1 && length(var.name) <= 60 && !can(regex("[^A-Za-z0-9. -]", var.name))
    error_message = "1. Name length should be between 1 and 60 characters.\n2. Name should consist only of alphanumeric characters, dots, spaces and dashes."
  }
}

variable "aws_lb_target_group_arn" {
  type = string
  description = "aws_lb_target_group_arn"
}

variable "aws_subnet_id" {
  type = list(string)
  description = "AWS Subnet ids"
}

variable "aws_security_group_alb" {
  type = string
  description = "aws_security_group_alb"
}