resource "aws_security_group" "cluster" {
  name_prefix = var.cluster_name
  description = "EKS cluster security group."
  vpc_id      = module.vpc.vpc_id

  tags = merge(var.tags, {
    "Name"                                      = "${var.cluster_name}-eks-cluster-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  })
}

resource "aws_security_group_rule" "inbound_22" {
  description              = "Allow port 22"
  from_port                = 1337
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.cluster.id
  cidr_blocks              = ["0.0.0.0/0"]
  to_port                  = 1337
  type                     = "ingress"
}

resource "aws_security_group_rule" "inbound_443" {
  description              = "Allow port 443"
  from_port                = 443
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.cluster.id
  cidr_blocks              = ["0.0.0.0/0"]
  to_port                  = 443
  type                     = "ingress"
}