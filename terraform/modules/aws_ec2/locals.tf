locals {
  # vm-name = "${var.tag_name}-${random_string.gen-name.result}"
  subnets = var.aws_subnet_id
}
