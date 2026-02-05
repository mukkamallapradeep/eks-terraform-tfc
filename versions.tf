terraform {
  required_version = ">= 1.5.0"

  cloud {
    organization = "Poc05-Organization"   # <-- change

    workspaces {
      name = "eks-terraform-tfc"         # <-- change
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
