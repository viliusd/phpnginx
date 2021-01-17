output "aws_subnet_id" {
    value = module.aws_subnet.aws_subnet_id
}

output "aws_subnet_arn" {
    value = module.aws_subnet.aws_subnet_arn
}

output "ec2_instance_arn" {
    value = module.aws_ec2.ec2_instance_arn
}

output "ec2_instance_public_ip" {
    value = module.aws_ec2.ec2_instance_public_ip
}

output "ec2_instance_id" {
    value = module.aws_ec2.ec2_instance_id
}