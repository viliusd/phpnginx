variable "name" {
  description = "Name"
  type = string
  validation {
    condition = length(var.name) >= 1 && length(var.name) <= 60 && !can(regex("[^A-Za-z0-9. -]", var.name))
    error_message = "1. Name length should be between 1 and 60 characters.\n2. Name should consist only of alphanumeric characters, dots, spaces and dashes."
  }
}

variable "vpc_id" {
  type = string
  description = "AWS VPC id"
}

variable "ingress_cidr_block" {
  type = list(string)
  description = "list of IP allowed for incoming connections"
}