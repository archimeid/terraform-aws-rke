output "load_balancer_private_ip" {
  value = module.aws_kubernetes_nodes.load_balancer_private_ip
}

output "bastion_public_ip" {
  value = module.aws_kubernetes_nodes.bastion_public_ip
}