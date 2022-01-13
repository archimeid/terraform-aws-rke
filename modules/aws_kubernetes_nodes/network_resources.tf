resource "aws_vpc" "kubernetes" {
  cidr_block = var.vpc_cidr_block

  tags {
      Terraform = true
      Name = "kubernetes_vpc"
  }
}