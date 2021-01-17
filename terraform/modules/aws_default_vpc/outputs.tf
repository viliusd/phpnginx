output "aws_default_vpc_id" {
    value = aws_default_vpc.default.id
}

output "aws_default_vpc_arn" {
    value = aws_default_vpc.default.arn
}

# output "aws_subnet_id" {
#     value = aws_subnet.main.id
# }

# output "aws_subnet_arn" {
#     value = aws_subnet.main.arn
# }