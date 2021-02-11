#Creating new AWS subnet in two availability zones
module "aws_subnet" {
  source = "../modules/aws_subnet"
  providers = {
    aws = aws
  }
  name                      = local.env_name
  vpc_id                    = aws_default_vpc.default.id
  subnet_availability_zones = ["eu-west-2a", "eu-west-2b"]
}

#Creating security groups to be reused in other modules
module "aws_security_groups" {
  source = "../modules/aws_security_groups"
  providers = {
    aws = aws
  }
  name               = local.env_name
  vpc_id             = aws_default_vpc.default.id
  ingress_cidr_block = ["85.206.68.114/32", "172.31.0.0/16"] #my home IP
}

#Creating AWS instances in this example in total 4 (2 green, 2 blue) and attaching security groups
module "aws_ec2" {
  source = "../modules/aws_ec2"
  providers = {
    aws = aws
  }
  name                                      = local.env_name
  enable_green_env                          = true
  enable_blue_env                           = true
  blue_instance_count                       = 2
  green_instance_count                      = 2
  tag_name                                  = "${local.env_name}-one"
  instance_ami_id                           = "ami-0ff4c8fb495a5a50d"
  instance_type                             = "t2.micro"
  aws_subnet_id                             = module.aws_subnet.aws_subnet_id #improvement needed
  aws_security_group_allow_http_to_instance = module.aws_security_groups.aws_security_group_allow_http_to_instance
  aws_security_group_allow_ssh              = module.aws_security_groups.aws_security_group_allow_ssh
  vpc_id                                    = aws_default_vpc.default.id
  associate_public_ip_address               = true
  public_key                                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpkCFnnIX5DqU6HXSt/ht01aAMdmk3QP8o0qdpQml4ZZ6jgszKwGOJZLk1Tip2CmXByDZZC9juiepqoIWgLC0xRuacbXN/VRn9cOkyEbY+WjbICAELjstTc1cXbByM7kpGsIC4UzpvLVoPVVdN/Tpj7M8Rt456jSXng5q1vH8ECKL0byuimBo5mSCVYwjeNRfQFNBLxGnTIEDfuBsYHoHqEZPM7/pZzvbWtQPwnEm70Y1Ox3BtCyO31tg8OnfUFBcLnAKRKPJYxIz6a4kxNgx/GgIZn80T/pqCy5biCQe1poj9n3FNoFil0sKQXD9r2bcjzR3iHtJCFP8UwMcrgRWcBOBexar14d0OfClKdy2JzQFgNkSMfdLYvEDSWeOo8UXn4ah7SvVWSy/chni4oY7064AtHqeWJcHiXMtWBKMT+sWphjAxyCLknv0x+Yhi1Zms9DrAB5jZw7iOOqmfY/eJrpjwIeKZq0jYlKP+1P4rSQJk9bx+agS6QRb8lSIJObs= vilius@LTP-VILIDUDE" #public RSA key
  
}

#Creating AWS ALB, note commented out blue arn therefor it will point now to Green EC2 instances group
module "aws_alb" {
  source = "../modules/aws_alb"
  providers = {
    aws = aws
  }
  name                    = local.env_name
  aws_security_group_alb  = module.aws_security_groups.aws_security_group_alb
  aws_subnet_id           = module.aws_subnet.aws_subnet_id
  aws_lb_target_group_arn = module.aws_ec2.aws_lb_target_group_green_arn #ALB target group arn blue/green
  #aws_lb_target_group_arn = module.aws_ec2.aws_lb_target_group_blue_arn #ALB target group arn blue/green

}