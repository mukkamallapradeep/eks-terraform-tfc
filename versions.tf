terraform {
  required_version = ">= 1.5.0"

  cloud {
    organization = "your_org_name"   # <-- change

    workspaces {
      name = "eks-workspace"         # <-- change
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
