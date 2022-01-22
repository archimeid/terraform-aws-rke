output "loadbalancer_private_ip" {
  value = aws_eip.load_balancer.public_ip
}

output "bastion_public_ip" {
  value = aws_eip.bastion.public_ip
}