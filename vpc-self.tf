# Getting the aws availability zones and creating a random string for the cluster name.
data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

# Setting the cluster name using the random string generated above.
locals {
  cluster_name = "taha-eks-${random_string.suffix.result}"
}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.12.0"
  name            = "taha-eks-vpc"
  cidr            = var.cidr
  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private-subnet
  public_subnets  = var.public-subnet

  # Enables the private subnet resources to download updates from the internet.
  # Setting single nat gateway to true will create a single NAT gateway in the public subnet in a single AZ.
  enable_nat_gateway = true
  single_nat_gateway = true

  # allows dns resolution and hostnames in the VPC
  # This is required for the EKS cluster to function properly.
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    Terraform                                     = "true"
    Environment                                   = "dev"
  }
}
