output "aws_subnet_id" {
    value = ["${aws_subnet.public_green_blue.*.id}"]
}

# output "aws_subnet_arn" {
#     value = aws_subnet.main.arn
# }