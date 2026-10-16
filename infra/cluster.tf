# this means that the cluster will be created in a VPC with private subnets, and the nodes will be able to access the internet through a NAT gateway if enabled.

resource "aws_eks_cluster" "this" {
  name     = local.name
  version  = var.kubernetes_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids = module.vpc.private_subnets

    endpoint_private_access = true
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  upgrade_policy {
    support_type = "STANDARD"
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster
  ]

  bootstrap_self_managed_addons = false

  tags = local.tags
}

# moved {
#   from = aws_eks_addon.this["vpc-cni"]
#   to   = aws_eks_addon.vpc_cni
# }

# moved {
#   from = aws_eks_addon.this["kube-proxy"]
#   to   = aws_eks_addon.kube_proxy
# }

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = local.tags
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = local.tags
}

resource "aws_eks_addon" "core_dns" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"


  depends_on = [
    aws_eks_node_group.this
  ]
  tags = local.tags
}