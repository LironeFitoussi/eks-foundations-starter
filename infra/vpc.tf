module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.6.1"

  name = local.name   // Name of the VPC - eks-foundations
  cidr = var.vpc_cidr // CIDR block for the VPC - 10.0.0.0/16
  azs  = local.azs    // Availability zones for the VPC - slice(data.aws_availability_zones.available.names, 0, 2) - "il-central-1a", "il-central-1b"

  # cidrsubnet() - calculates the subnet CIDR block for each subnet based on the VPC CIDR block and the number of subnets.
  // Private subnets for the VPC - ["10.0.0.0/20", "10.0.1.0/20"]

  #   Private subnet range: 10.0.0.0 to 10.0.127.0
  #  "10.0.0.0/16"  -> 00001010.00000000.00000000.00000000
  #                   Fixed -----------.Free bits -------
  #   > cidrsubnet(var.vpc_cidr, 4, 0) 
  #   "10.0.0.0/20" -> 00001010.00000000.00000000.00000000
  #                    Fixed ---------------|Free bits ---
  #   > cidrsubnet(var.vpc_cidr, 4, 1)
  #   "10.0.1.0/20" -> 00001010.00000000.00010000.00000000
  #                    Fixed ---------------|Free bits ---
  private_subnets = [
    for i, az in local.azs : cidrsubnet(var.vpc_cidr, 4, i)
  ]

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  #   Public subnets range: 10.0.128.0 to 10.0.255.0
  #  "10.0.128.0/16"  -> 00001010.00000000.10000000.00000000
  #                   Fixed -----------.Free bits -------
  #   > cidrsubnet(var.vpc_cidr, 8, 128) 
  #   "10.0.128.0/24" -> 00001010.00000000.10000000.00000000
  #                      Fixed --------------------|Free bits
  #   > cidrsubnet(var.vpc_cidr, 8, 129)
  #   "10.0.1.0/20"   -> 00001010.00000000.10000001.00000000
  #                      Fixed --------------------|Free bits
  public_subnets = [
    for i, az in local.azs : cidrsubnet(var.vpc_cidr, 8, i + local.public_subnet_offset)
  ]

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  enable_nat_gateway = true
  single_nat_gateway = true
}
