variable "cluster_name" {
  type        = string
  default     = "jumia_cluster"
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  default     = "1.21"
  description = "Version of the EKS cluster"
}

variable "tags" {
  description = "  Tags map to be add in all resources."
  type        = map(string)
  default = {
    Name = "jumia"
    Project = "jumia_challenge"
  }
}

# VPC
variable "cidr_block" {
  description = "VPC's CIDR block."
  type        = string
  default     = "172.16.0.0/16"
}
variable "public_subnets" {
  description = "Public subnets list created on VPC."
  type        = list(string)
  default     = ["172.16.4.0/24", "172.16.5.0/24"]
}

variable "private_subnets" {
  description = "Private subnets list created on VPC."
  type        = list(string)
  default     = ["172.16.6.0/24", "172.16.2.0/24"]
}

# IAM
variable "iam_cluster_role_name" {
  description = "Cluster EKS role name."
  type        = string
  default     = ""
}

variable "iam_nodes_role_name" {
  description = "Cluster EKS Node Group role name."
  type        = string
  default     = ""
}

# Node Groups
variable "node_groups" {
  description = "Map for node groups creation."
  type        = any
  default = {
    pvcy = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2
      instance_types   = ["t2.medium"]
    }
  }
}