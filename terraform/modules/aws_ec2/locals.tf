locals {
  vm-name = "${var.tag_name}-${random_string.gen-name.result}"
}