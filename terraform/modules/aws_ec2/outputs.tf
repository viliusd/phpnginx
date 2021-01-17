output "ec2_instance_arn" {
    value = aws_instance.name.*.arn
}

output "ec2_instance_id" {
    value = aws_instance.name.*.id
}
output "ec2_instance_public_ip" {
    value = aws_instance.name.*.public_ip
}

output "ec2_aws_security_group" {
    value = aws_security_group.allow_ssh.id
}

output "ec2_aws_security_group_http" {
    value = aws_security_group.allow_http.id
}