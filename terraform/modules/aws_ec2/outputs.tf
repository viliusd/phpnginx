output "ec2_green_instance_arn" {
    value = aws_instance.green.*.arn
}

output "ec2_green_instance_id" {
    value = aws_instance.green.*.id
}
output "ec2_green_instance_public_ip" {
    value = aws_instance.green.*.public_ip
}

output "ec2_aws_security_group" {
    value = aws_security_group.allow_ssh.id
}

output "ec2_aws_security_group_http" {
    value = aws_security_group.allow_http.id
}

output "aws_lb_target_group_blue_arn" {
    value = aws_lb_target_group.blue.arn
}