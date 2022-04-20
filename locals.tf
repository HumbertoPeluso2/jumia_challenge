locals {
  iam_cluster_role_name        = var.iam_cluster_role_name != "" ? var.iam_cluster_role_name : null
  iam_cluster_role_name_prefix = var.iam_cluster_role_name != "" ? null : var.cluster_name
  iam_nodes_role_name        = var.iam_nodes_role_name != "" ? var.iam_nodes_role_name : null
  iam_nodes_role_name_prefix = var.iam_nodes_role_name != "" ? null : var.cluster_name

  node_groups_expanded = { for k, v in var.node_groups : k => merge(
    {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
    }, v)
  }

  instance_ids  = data.aws_instances.instances.ids
  elb_arn       = data.aws_lb.elb.arn

}
