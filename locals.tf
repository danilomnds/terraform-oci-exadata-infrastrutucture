locals {
  default_tags = {
    "IT.resource" : "database"
    "IT.deployedby" : "Terraform"
    "IT.provider" : "oci"
    "IT.create_date" : formatdate("DD/MM/YY hh:mm", timeadd(timestamp(), "-3h"))
  }
  defined_tags = merge(local.default_tags, var.defined_tags)
}