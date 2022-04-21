module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"
  namespace = "jumia"

  additional_set = [
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
      type  = "string"
    },
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"
      value = "tcp"
      type  = "string"
    },

    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-additional-resource-tags"
      value = "name=jumia_lb"
      type  = "string"
    }
  ]

  depends_on = [
    aws_eks_cluster.cluster,
    null_resource.update-kubeconfig
    ]
}

resource "aws_lb_listener" "nlb-listener-1337" {
  load_balancer_arn = local.elb_arn
  port              = "1337"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front-end-allow-1337.arn
  }
}

resource "aws_lb_target_group" "front-end-allow-1337" {
  name     = "routes-ssh"
  port     = 1337
  protocol = "TCP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "nlb-attachment-1337" {
  count = length(local.instance_ids)
  target_group_arn = aws_lb_target_group.front-end-allow-1337.arn
  target_id        = local.instance_ids[count.index]
  port             = 1337
  depends_on = [module.nginx-controller]
}

 resource "null_resource" "update-kubeconfig"{
   provisioner "local-exec" {
  
    working_dir = "./ingress"
    command = "ansible-playbook deploy-ingress.yaml" 
  }
  depends_on = [
    aws_eks_cluster.cluster
  ]
} 