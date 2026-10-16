### Networking
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix for related resources."
  type        = string
  default     = "eks-foundations"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_outbound_internet_access" {
  description = "Whether to deploy a NAT gateway to enable access from private subnets to the internet."
  type        = bool
  # default     = false
  default = true
}

# EKS Variables
variable "kubernetes_version" {
  description = "Kubernetes minor version for the control plane and managed add-ons."
  type        = string
  default     = "1.36"
}

variable "endpoint_public_access" {
  description = "Expose the Kubernetes API endpoint publicly so kubectl can reach it from outside the VPC."
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to reach the public API endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Node Groups

variable "node_instance_types" {
  description = "Instance types for the node group."
  type        = list(string)
  default     = ["t3.medium", "t3a.small", "t3.medium", "t3a.medium", "t3.large", "t3a.large"]
}

variable "node_desired_size" {
  description = "Desired number of instances for the nodes."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of instances for the nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of instances for the nodes."
  type        = number
  default     = 3
}

# Shared
variable "tags" {
  description = "Additional tags applied to every resource."
  type        = map(string)
  default = {
    # "Owner": "team-finance"
  }
}