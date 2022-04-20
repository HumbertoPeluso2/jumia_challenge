resource "aws_eks_cluster" "cluster" {
  name                      = var.cluster_name
  version                   = var.cluster_version
  role_arn                  = aws_iam_role.cluster.arn
  tags                      = var.tags

  vpc_config {
    subnet_ids              = module.vpc.private_subnets
  }

  depends_on = [
    aws_security_group_rule.inbound_22,
    aws_security_group_rule.inbound_443,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}