# phpnginx

Setup `credentials.sec` file in `terraform/main directory`

credentials.sec file content

[default]
aws_access_key_id = your_key
aws_secret_access_key = your_secret
aws_region=eu-west-2

-----------------------------------------------------------------------

Terraform version required 
"v0.13.3"
-----------------------------------------------------------------------
#COMMANDS TO be executed prior deployment

#If you do not have default VPC this command will create and output your default VPC ID
`aws ec2 create-default-vpc --region eu-west-2`

Import default VPC id
`terraform import aws_default_vpc.default vpc_default_id`
-----------------------------------------------------------------------
In order to access VMs 

Provide your RSA public key in `module.aws_ec2.public_key`

Provide your YOUR_IP which you will be accessing from in `module.aws_security_groups.ingress_cidr_block`
-----------------------------------------------------------------------
Thats it! Run commands in main catalog:

terraform workspace new dev
terraform init
terraform apply

OUTPUT VALUES

*aws_lb_dns* is your ALB DNS name