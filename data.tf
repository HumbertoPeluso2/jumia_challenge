data "aws_availability_zones" "available" {}

data "aws_iam_policy_document" "cluster" {
  statement {
    sid     = "EKSClusterAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "nodes" {
  statement {
    sid     = "EKSNodesAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_instances" "instances" {
  
  instance_tags = {
    "eks:cluster-name" = var.cluster_name
  }
  
}

data "aws_lb" "elb" {
  tags = {
    name = "jumia_lb"
  }
  depends_on = [module.nginx-controller]
}

