module "aws_ecr" {
    source = "../modules/aws_ecr"
    providers = {
    aws = aws
    }
    name = local.env_name
    env_name = "dev"
}

module "aws_vpc" {
    source = "../modules/aws_vpc"
    providers = {
    aws = aws
    }
    name = local.env_name
    env_name = "dev"
    vpc_cidr_block = "10.0.0.0/16"
    subnet_cidr_block = "10.0.1.0/24"
    subnet_availability_zone = "eu-west-2a"
}


# module "aws_default_vpc" {
#     source = "../modules/aws_default_vpc"
#     providers = {
#     aws = aws
#     }
#     name = local.env_name
#     env_name = "dev"
# }

module "aws_ec2" {
    source = "../modules/aws_ec2"
    providers = {
    aws = aws
    }
    name = local.env_name
    tag_name = "${local.env_name}-frontend"
    env_name = "dev"
    instance_ami_id = "ami-0ff4c8fb495a5a50d"
    instance_type = "t2.micro"
    aws_subnet_id = "subnet-083d816835215afa4"
    aws_vpc_id = "vpc-0e644d62c82044dc4"
    ingress_cidr_block = ["85.206.68.114/32", "172.31.0.0/16"]
}