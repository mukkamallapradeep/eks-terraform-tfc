provider "aws" {
  region = var.region
}

# ----- VPC -----
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Project = var.cluster_name
  }
}

# ----- EKS -----
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    ng-default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.small"] # small/cheap for POC (not free)
      capacity_type  = "ON_DEMAND"

      tags = {
        Name = "${var.cluster_name}-ng"
      }
    }
  }

  tags = {
    Project = var.cluster_name
  }
}
