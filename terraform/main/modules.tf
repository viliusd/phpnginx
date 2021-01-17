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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeAP7qQic1i8ggCE8t0hg6c5CQcffJ6XrCmogS/NMGACW1QmcisenZAANbvEtT4E+iSVzT/VTFW+F8gKBF5nYRUrDzLJ/hn9khyKpmHiILvLke8ety2iuD+/HclTmZipbyljg6WTP8tgltD9CIVqmqgz12G6dW4Z3ylTxT6Hqm297SrtG9X27FyNGnG2TjvARG+JNsHhhbrEj4KdcM7VhVKNLa+hghhm3vuqU3X7Voab7+ZS237JxywVdRa0W98jf6vmUbm1QNXO8CwX/YnstE8qD/LrzIb9S9Z2X/UF5BeOXB0ODcMSJua2xhcIgumxVX0g2tOIPDrh4wAebDTmcf"
}

module "aws_alb" {
    source = "../modules/aws_alb"
    providers = {
    aws = aws
    }
    name = "${local.env_name}-alb"
    env_name = "dev"
    cidr_block = "172.31.0.0/16"
    aws_vpc_id = "vpc-0e644d62c82044dc4"
    ec2_aws_security_group = module.aws_ec2.ec2_aws_security_group
    aws_subnet_id = ["subnet-083d816835215afa4", "subnet-090b51e812677379b"]
}