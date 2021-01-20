output "aws_subnet_id" {
    value = module.aws_subnet.aws_subnet_id
}

output "ec2_green_instance_public_ip" {
    value = module.aws_ec2.ec2_green_instance_public_ip
}

output "ec2_green_instance_id" {
    value = module.aws_ec2.ec2_green_instance_id
}

output "aws_lb_dns" {
    value = module.aws_alb.aws_lb_dns
}