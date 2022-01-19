module "aws_kubernetes_nodes" {
  source = "./modules/aws_kubernetes_nodes"

  aws_region = var.aws_region
  aws_profile = var.aws_profile
  vpc_cidr_block = var.vpc_cidr_block
  domain_name = var.domain_name
}