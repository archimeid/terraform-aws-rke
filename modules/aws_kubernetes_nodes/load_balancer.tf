resource "aws_security_group" "load_balancer" {
  name = "k8s-lb-sg"
  description = "Allow SSH ingress traffic from bastion, HTTP, HTTPS from Internet and allow all egress traffic"
  vpc_id = aws_vpc.kubernetes.id

  # Allow incoming SSH traffic from Bastion
  ingress {
    description = "Allow incoming SSH traffic from Bastion"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion.id ]
  }

  # Allow outgoing traffic
  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
      Name = "k8s-lb-sg"
  }
}

resource "aws_instance" "load_balancer" {
  ami           = data.aws_ssm_parameter.amazon_linux_arm_ami.value
  instance_type = "t4g.nano"

  key_name = aws_key_pair.k8s.key_name

  subnet_id = aws_subnet.public_subnet_2.id

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 10
    volume_type           = "gp2"

    tags = {
      Name = "K8s Load Balancer"
    }
  }

  vpc_security_group_ids = [aws_security_group.load_balancer.id]

  tags = {
    Name = "K8s Load Balancer"
  }
}

resource "aws_eip" "load_balancer" {
  instance = aws_instance.load_balancer.id
  vpc      = true

  depends_on = [aws_internet_gateway.gw]
}