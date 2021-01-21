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
  type = list(string)
  description = "AWS Subnet id"
}

variable "tag_name" {
  type = string
  description = "EC2 instance tag name"
}

variable "vpc_id" {
  type = string
  description = "AWS VPC id"
}

variable "public_key" {
  type = string
  description = "public_key"
}

variable "associate_public_ip_address" {
  type = bool
  default = false
  description = "Associate IP address"
}

variable "enable_green_env" {
  description = "Enable green environment"
  type        = bool
  default     = false
}

variable "enable_blue_env" {
  description = "Enable blue environment"
  type        = bool
  default     = false
}

variable "green_instance_count" {
  type = number
  default = 2
  description = "Green instance count"
}

variable "blue_instance_count" {
  type = number
  default = 2
  description = "Blue instance count"
}

variable "aws_security_group_allow_http_to_instance" {
  type = string
  description = "aws_security_group_allow_http_to_instance"
}

variable "aws_security_group_allow_ssh" {
  type = string
  description = "aws_security_group_allow_ssh"
}