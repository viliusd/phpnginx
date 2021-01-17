locals {
  default_tags = merge(
    {
      IsProtected = 1
      IsOwnedBy = "Terraform"
      Name = var.name
    },
    var.env_name == "" ? {} : { Environment = var.env_name }
  )
}