module "aws_subnet" {
    source = "../modules/aws_subnet"
    providers = {
    aws = aws
    }
    name = local.env_name
    vpc_id = aws_default_vpc.default.id
    subnet_availability_zones = ["eu-west-2a", "eu-west-2b"]
}

module "aws_security_groups" {
    source = "../modules/aws_security_groups"
    providers = {
    aws = aws
    }   
    name = local.env_name
    vpc_id = aws_default_vpc.default.id
    ingress_cidr_block = ["YOUR_IP", "172.31.0.0/16"] #my home IP
}
module "aws_ec2" {
    source = "../modules/aws_ec2"
    providers = {
    aws = aws
    }
    name = local.env_name
    enable_green_env = true
    enable_blue_env = true
    blue_instance_count = 2
    green_instance_count = 2
    tag_name = "${local.env_name}-one"
    instance_ami_id = "ami-0ff4c8fb495a5a50d"
    instance_type = "t2.micro"
    aws_subnet_id = module.aws_subnet.aws_subnet_id #improvement needed
    aws_security_group_allow_http_to_instance = module.aws_security_groups.aws_security_group_allow_http_to_instance
    aws_security_group_allow_ssh = module.aws_security_groups.aws_security_group_allow_ssh
    vpc_id = aws_default_vpc.default.id
    associate_public_ip_address = true 
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeAP7qQic1i8ggCE8t0hg6c5CQcffJ6XrCmogS/NMGACW1QmcisenZAANbvEtT4E+iSVzT/VTFW+F8gKBF5nYRUrDzLJ/hn9khyKpmHiILvLke8ety2iuD+/HclTmZipbyljg6WTP8tgltD9CIVqmqgz12G6dW4Z3ylTxT6Hqm297SrtG9X27FyNGnG2TjvARG+JNsHhhbrEj4KdcM7VhVKNLa+hghhm3vuqU3X7Voab7+ZS237JxywVdRa0W98jf6vmUbm1QNXO8CwX/YnstE8qD/LrzIb9S9Z2X/UF5BeOXB0ODcMSJua2xhcIgumxVX0g2tOIPDrh4wAebDTmcf" #public RSA key
} 

module "aws_alb" {
    source = "../modules/aws_alb"
    providers = {
    aws = aws
    }
    name = local.env_name
    aws_security_group_alb = module.aws_security_groups.aws_security_group_alb
    aws_subnet_id= module.aws_subnet.aws_subnet_id
    aws_lb_target_group_arn = module.aws_ec2.aws_lb_target_group_green_arn #ALB target group arn blue/green
    #aws_lb_target_group_arn = module.aws_ec2.aws_lb_target_group_blue_arn #ALB target group arn blue/green

}