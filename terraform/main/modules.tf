module "aws_subnet" {
    source = "../modules/aws_subnet"
    providers = {
    aws = aws
    }
    name = local.env_name
    #env_name = "dev"
    vpc_id = aws_default_vpc.default.id
    subnet_cidr_block = "172.31.48.0/20"
    subnet_availability_zone = "eu-west-2a"
}

module "aws_ec2" {
    source = "../modules/aws_ec2"
    providers = {
    aws = aws
    }
    name = local.env_name
    vm_count = "2"
    tag_name = "${local.env_name}-frontend"
    env_name = "dev"
    instance_ami_id = "ami-0ff4c8fb495a5a50d"
    instance_type = "t2.micro"
    aws_subnet_id = module.aws_subnet.aws_subnet_id
    vpc_id = aws_default_vpc.default.id
    ingress_cidr_block = ["85.206.68.114/32", "172.31.0.0/16"]
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeAP7qQic1i8ggCE8t0hg6c5CQcffJ6XrCmogS/NMGACW1QmcisenZAANbvEtT4E+iSVzT/VTFW+F8gKBF5nYRUrDzLJ/hn9khyKpmHiILvLke8ety2iuD+/HclTmZipbyljg6WTP8tgltD9CIVqmqgz12G6dW4Z3ylTxT6Hqm297SrtG9X27FyNGnG2TjvARG+JNsHhhbrEj4KdcM7VhVKNLa+hghhm3vuqU3X7Voab7+ZS237JxywVdRa0W98jf6vmUbm1QNXO8CwX/YnstE8qD/LrzIb9S9Z2X/UF5BeOXB0ODcMSJua2xhcIgumxVX0g2tOIPDrh4wAebDTmcf"
}

module "aws_alb" {
    source = "../modules/aws_alb"
    providers = {
    aws = aws
    }
    name = "${local.env_name}-alb"
    cidr_block = "172.31.0.0/16"
    aws_vpc_id = aws_default_vpc.default.id
    ec2_aws_security_group = module.aws_ec2.ec2_aws_security_group
    ec2_aws_security_group_http = module.aws_ec2.ec2_aws_security_group_http
    aws_subnet_id = ["subnet-0f55044d8e42b17bb", "subnet-0c2ad9b4068e701d8"] #Copying from default VPC created default subnet ids
    aws_instance_id = module.aws_ec2.ec2_instance_id[0]
}