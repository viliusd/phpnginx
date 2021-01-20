provider "aws" {}

resource "aws_subnet" "public_green_blue" {
  count = length(var.subnet_availability_zones)
  vpc_id     = var.vpc_id
  cidr_block = "172.31.${count.index + 60}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    Name = "${var.name}-${count.index + 60}-subnet"
  }
}
