provider "aws" {}

resource "aws_lb" "alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ec2_aws_security_group, var.ec2_aws_security_group_http]
  subnets            = var.aws_subnet_id

  enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = var.name
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = var.aws_lb_target_group_blue_arn
  }
}