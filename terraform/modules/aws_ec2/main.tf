provider "aws" {}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = var.aws_vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}



resource "aws_network_interface" "aws_instance" {
  subnet_id       = var.aws_subnet_id
  tags = {
    Name = "AWS_network_interface"
  }
}

resource "aws_key_pair" "communication_key" {
  key_name   = "communication-key"
  public_key = var.public_key
}

resource "aws_instance" "name" {
  ami = var.instance_ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.communication_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
  # network_interface {
  #   network_interface_id = aws_network_interface.aws_instance.id
  #   device_index         = 0
  # }

  tags = {
    Name = var.tag_name
  }

  #associate_public_ip_address = var.assign_public_ip_address
}

