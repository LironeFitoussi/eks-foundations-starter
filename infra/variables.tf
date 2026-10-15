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

variable "tags" {
  description = "Additional tags applied to every resource."
  type        = map(string)
  default = {
    # "Owner": "team-finance"
  }
}