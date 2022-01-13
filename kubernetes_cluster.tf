module "aws_kubernetes_nodes" {
  source = "./modules/aws_kubernetes_nodes"

  aws_region = "eu-west-3"
  vpc_cidr_block = "10.0.0.0/16"
}