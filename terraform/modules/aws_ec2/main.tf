provider "aws" {}


resource "random_string" "gen-name" {
  length  = 12
  upper   = false
  number  = true
  lower   = true
  special = false
}

resource "aws_key_pair" "communication_key" {
  key_name   = "communication-key"
  public_key = var.public_key
}

resource "aws_instance" "green" {
  count = var.enable_green_env ? var.green_instance_count : 0
  ami = var.instance_ami_id
  subnet_id =  "${element(var.aws_subnet_id, count.index)}"
  instance_type = var.instance_type
  key_name = aws_key_pair.communication_key.key_name
  vpc_security_group_ids = [var.aws_security_group_allow_ssh, var.aws_security_group_allow_http_to_instance]

  user_data     = <<-EOF
                  #!/bin/bash
                  sudo apt install nginx -y
                  sudo ufw allow 'Nginx HTTP'
                  EOF

  tags = {
    Name = "${var.tag_name}-green-${count.index + 1}"
  }

  associate_public_ip_address = var.associate_public_ip_address
}

resource "aws_instance" "blue" {
  count = var.enable_blue_env ? var.blue_instance_count : 0
  ami = var.instance_ami_id
  subnet_id =  "${element(var.aws_subnet_id, count.index)}"
  instance_type = var.instance_type
  key_name = aws_key_pair.communication_key.key_name
  vpc_security_group_ids = [var.aws_security_group_allow_ssh, var.aws_security_group_allow_http_to_instance]

  user_data     = <<-EOF
                  #!/bin/bash
                  sudo apt install nginx -y
                  sudo ufw allow 'Nginx HTTP'
                  EOF

  tags = {
    Name = "${var.tag_name}-blue-${count.index + 1}"
  }

  associate_public_ip_address = var.associate_public_ip_address
}

resource "aws_lb_target_group" "green" {
  name     = "green-${var.tag_name}-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
  stickiness {
    type = "lb_cookie"
    enabled         = false
  }

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "green" {
  count            = length(aws_instance.green)
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.green[count.index].id
  port             = 80
}

resource "aws_lb_target_group" "blue" {
  name     = "blue-${var.tag_name}-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
  stickiness {
    type = "lb_cookie"
    enabled         = false
  }
  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "blue" {
  count            = length(aws_instance.blue)
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.blue[count.index].id
  port             = 80
}