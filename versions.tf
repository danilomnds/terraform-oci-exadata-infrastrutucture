terraform {
  required_version = ">= 1.9.5"
  required_providers {
    oci = {
      version = ">= 6.8.0"
    }
  }
}

# if you are deploying the resource outside your home region uncomment this part of the code
/*
provider "oci" {
  alias        = "oci-gru"
  tenancy_ocid = "<your id>"
  region       = "<region name>"
}*/