locals {
    vpc_cidr = "10.0.0.0/16"
    availability_zones      = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "dev-vpc"
  cidr = local.vpc_cidr

  azs             = local.availability_zones
  private_subnets = [for k, v in local.availability_zones : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.availability_zones : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.availability_zones : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Name = "dev-vpc"
    Terraform = "true"
    Environment = "dev"
    Application = "voting-app"
  }
}