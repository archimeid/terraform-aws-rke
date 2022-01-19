data "aws_ssm_parameter" "amazon_linux_arm_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-arm64-gp2"
}

resource "aws_security_group" "bastion" {
  name = "bastion-sg"
  description = "Allow SSH ingress traffic and allow all egress traffic"
  vpc_id = aws_vpc.kubernetes.id

  # Allow incoming SSH traffic
  ingress {
    description = "Allow incoming SSH traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
      Name = "bastion-sg"
  }
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ssm_parameter.amazon_linux_arm_ami.value
  instance_type = "t4g.nano"

  key_name = aws_key_pair.k8s.key_name

  subnet_id = aws_subnet.public_subnet_1.id

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp2"

    tags = {
      Name = "Bastion SSH"
    }
  }

  vpc_security_group_ids = [aws_security_group.bastion.id]

  tags = {
    Name = "Bastion SSH"
  }
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc      = true

  depends_on = [aws_internet_gateway.gw]
}