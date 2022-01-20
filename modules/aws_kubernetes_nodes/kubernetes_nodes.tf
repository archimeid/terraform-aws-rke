resource "aws_security_group" "kubernetes_nodes" {
  name = "k8s-nodes-sg"
  description = "Allow SSH ingress traffic from bastion-sg and allow all egress traffic"
  vpc_id = aws_vpc.kubernetes.id

  # Allow incoming SSH traffic from Bastion Security Group
  ingress {
    description = "Allow incoming SSH traffic from Bastion host"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion.id ]
    ipv6_cidr_blocks = ["::/0"]
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
      Name = "k8s-nodes-sg"
  }
}

resource "aws_instance" "controle_plane_node" {
  count = 2

  ami           = data.aws_ssm_parameter.amazon_linux_ami.value
  instance_type = "t3a.micro"

  key_name = aws_key_pair.k8s.key_name

  subnet_id = local.private_subnets_id[count.index % 2]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp2"

    tags = {
      Name = "Control Plane Node ${count.index + 1}"
    }
  }

  vpc_security_group_ids = [aws_security_group.kubernetes_nodes.id]

  tags = {
    Name = "Control Plane Node ${count.index + 1}"
  }
}

resource "aws_instance" "worker_node" {
  count = 2

  ami           = data.aws_ssm_parameter.amazon_linux_ami.value
  instance_type = "t3a.micro"

  key_name = aws_key_pair.k8s.key_name

  subnet_id = local.private_subnets_id[count.index % 2]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp2"

    tags = {
      Name = "Worker Node ${count.index + 1}"
    }
  }

  vpc_security_group_ids = [aws_security_group.kubernetes_nodes.id]

  tags = {
    Name = "Worker Node ${count.index + 1}"
  }
}