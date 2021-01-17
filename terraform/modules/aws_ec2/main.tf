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
    #cidr_blocks = ["85.206.68.114/32", "172.31.0.0/16"].
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeAP7qQic1i8ggCE8t0hg6c5CQcffJ6XrCmogS/NMGACW1QmcisenZAANbvEtT4E+iSVzT/VTFW+F8gKBF5nYRUrDzLJ/hn9khyKpmHiILvLke8ety2iuD+/HclTmZipbyljg6WTP8tgltD9CIVqmqgz12G6dW4Z3ylTxT6Hqm297SrtG9X27FyNGnG2TjvARG+JNsHhhbrEj4KdcM7VhVKNLa+hghhm3vuqU3X7Voab7+ZS237JxywVdRa0W98jf6vmUbm1QNXO8CwX/YnstE8qD/LrzIb9S9Z2X/UF5BeOXB0ODcMSJua2xhcIgumxVX0g2tOIPDrh4wAebDTmcf"
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

