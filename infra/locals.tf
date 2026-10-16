locals {
  name = var.cluster_name

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnet_offset = 128

  # eks_addons = {
  #   "vpc-cni"    = {}
  #   "kube-proxy" = {}
  # }

  tags = merge(
    {
      Project   = "eks-foundations"
      ManagedBy = "terraform"
    },
    var.tags
  )
}
