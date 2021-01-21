output "ec2_green_instance_arn" {
    value = aws_instance.green.*.arn
}

output "ec2_green_instance_id" {
    value = aws_instance.green.*.id
}

output "ec2_blue_instance_id" {
    value = aws_instance.blue.*.id
}
output "ec2_green_instance_public_ip" {
    value = aws_instance.green.*.public_ip
}

output "ec2_blue_instance_public_ip" {
    value = aws_instance.blue.*.public_ip
}

output "aws_lb_target_group_blue_arn" {
    value = aws_lb_target_group.blue.arn
}

output "aws_lb_target_group_green_arn" {
    value = aws_lb_target_group.green.arn
}