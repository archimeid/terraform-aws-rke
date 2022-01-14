resource "aws_vpc" "kubernetes" {
  cidr_block = var.vpc_cidr_block

  tags = {
      Terraform = true
      Name = "kubernetes_vpc"
  }
}

data "aws_availability_zone" "availability_zone_a" {
  name = local.az1_name
}

data "aws_availability_zone" "availability_zone_b" {
  name = local.az2_name
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.kubernetes.id
  cidr_block = local.public_subnet1_cidr_block
  availability_zone = data.aws_availability_zone.availability_zone_a.id
  map_public_ip_on_launch = true

  tags = {
    Terraform = true
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.kubernetes.id
  cidr_block = local.public_subnet2_cidr_block
  availability_zone = data.aws_availability_zone.availability_zone_b.id
  map_public_ip_on_launch = true

  tags = {
    Terraform = true
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.kubernetes.id
  cidr_block = local.private_subnet1_cidr_block
  availability_zone = data.aws_availability_zone.availability_zone_a.id
  map_public_ip_on_launch = false

  tags = {
    Terraform = true
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.kubernetes.id
  cidr_block = local.private_subnet2_cidr_block
  availability_zone = data.aws_availability_zone.availability_zone_b.id
  map_public_ip_on_launch = false

  tags = {
    Terraform = true
    Name = "private-subnet-2"
  }
}