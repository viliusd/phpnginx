provider "aws" {}

resource "aws_instance" "name" {
  ami = var.instance_ami_id
  instance_type = var.instance_type
  associate_public_ip_address = var.assign_public_ip_address
}