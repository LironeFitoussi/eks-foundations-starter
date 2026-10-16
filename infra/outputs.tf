# output "aws_region" {
#   value = data.aws_region.current.region
# }

# output "us_region" {
#     value = data.aws_region.current.region
# }

# output "azs" {
#   value = data.aws_availability_zones.available.names
# }

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes version running on the control plane"
  value       = aws_eks_cluster.this.version
}

output "node_group_name" {
  description = "Name of the managed node group"
  value       = aws_eks_node_group.this.node_group_name
}

output "update_kubeconfig_command" {
  description = "Run this to point kubectl at the new cluster"
  value       = "aws eks update-kubeconfig --name ${aws_eks_cluster.this.name}"
}