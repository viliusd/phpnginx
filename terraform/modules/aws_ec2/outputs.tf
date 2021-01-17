output "ec2_instance_arn" {
    value = aws_instance.name.arn
}

output "ec2_instance_public_ip" {
    value = aws_instance.name.public_ip
}