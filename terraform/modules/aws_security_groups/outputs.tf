output "aws_security_group_allow_ssh" {
    value = aws_security_group.allow_ssh.id
}

output "aws_security_group_alb" {
    value = aws_security_group.alb.id
}

output "aws_security_group_allow_http_to_instance" {
    value = aws_security_group.allow_http_to_instance.id
}