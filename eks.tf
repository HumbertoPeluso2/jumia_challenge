resource "aws_eks_cluster" "cluster" {
  name                      = var.cluster_name
  version                   = var.cluster_version
  role_arn                  = aws_iam_role.cluster.arn
  tags                      = var.tags

  vpc_config {
    subnet_ids              = module.vpc.private_subnets
  }

  depends_on = [
    
  ]
}