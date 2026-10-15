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
