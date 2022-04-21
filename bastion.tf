module "bastion" {
  source = "Guimove/bastion/aws"
  bucket_name = "nobucket"
  region = "eu-west-2"
  vpc_id = module.vpc.vpc_id
  bastion_host_key_pair = "jumia_devops"
  create_dns_record = "false"
  elb_subnets = module.vpc.private_subnets
  auto_scaling_group_subnets = module.vpc.public_subnets
  private_ssh_port = 1337
  is_lb_private = false
  tags = {
    "name" = "jumia"
  }
}