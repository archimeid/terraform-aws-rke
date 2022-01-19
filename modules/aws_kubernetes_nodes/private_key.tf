resource "tls_private_key" "k8s" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "k8s" {
  key_name   = "k8s-key"
  public_key = tls_private_key.k8s.public_key_openssh
}

local_file "local_file" "k8s-private-key" {
  content = tls_private_key.k8s.private_key_pem
  filename = "${path.root}/generated/k8s_private_key"
}