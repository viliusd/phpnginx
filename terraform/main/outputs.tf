output "ecr_arn" {
    value = module.aws_ecr.ecr_arn
}

output "ecr_repo_url" {
    value = module.aws_ecr.ecr_repo_url
}

output "aws_vpc_id" {
    value = module.aws_vpc.aws_vpc_id
}

output "aws_vpc_arn" {
    value = module.aws_vpc.aws_vpc_arn
}


# output "aws_default_vpc_id" {
#     value = module.aws_default_vpc.aws_default_vpc_id
# }

# output "aws_default_vpc_arn" {
#     value = module.aws_default_vpc.aws_default_vpc_arn
# }
output "aws_subnet_id" {
    value = module.aws_vpc.aws_subnet_id
}

output "aws_subnet_arn" {
    value = module.aws_vpc.aws_subnet_arn
}

output "ec2_instance_arn" {
    value = module.aws_ec2.ec2_instance_arn
}

output "ec2_instance_public_ip" {
    value = module.aws_ec2.ec2_instance_public_ip
}