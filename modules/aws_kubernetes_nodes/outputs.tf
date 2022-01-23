output "load_balancer_private_ip" {
  value = aws_instance.load_balancer.private_ip
}

output "load_balancer_public_ip" {
  value = aws_eip.load_balancer.public_ip
}

output "bastion_public_ip" {
  value = aws_eip.bastion.public_ip
}