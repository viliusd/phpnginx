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

module "aws_ec2" {
    source = "../modules/aws_ec2"
    providers = {
    aws = aws
    }
    name = local.env_name
    env_name = "dev"
    instance_ami_id = "ami-0ff4c8fb495a5a50d"
    instance_type = "t2.micro"
    assign_public_ip_address = true
}


# module "ec2_cluster" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   version                = "~> 2.0"

#   name                   = "${local.env_name}-cluster"
#   instance_count         = 1

#   ami                    = "ami-0ff4c8fb495a5a50d"
#   instance_type          = "t2.micro"
#   key_name               = "front"
#   monitoring             = true
#   vpc_security_group_ids = ["sg-0673ae43a0d146551"]
#   subnet_id              = "subnet-04b3d9e5ac7b42619"

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#     Role = "Frontend"
#   }
# }

# resource "aws_instance" "frontend" {
#      ami           = "ami-0ff4c8fb495a5a50d"
#      instance_type = "t2.micro"
#      associate_public_ip_address = true
#      subnet_id = "subnet-04b3d9e5ac7b42619"
#      vpc_security_group_ids = ["sg-0673ae43a0d146551"]
#      tags = {
#           Name = "frontend-instance"
#      }
# }