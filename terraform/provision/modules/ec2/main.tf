data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web_server" {
  name        = "serpent-surge-web-server-sg"
  description = "Allow HTTPS to web server"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  description       = "HTTPS"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  description       = "HTTP"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  description       = "SSH"
  from_port         = 22
  to_port           = 22
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server.id
}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  description       = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server.id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.ssh_keypair
  vpc_security_group_ids = [aws_security_group.web_server.id]
  #   subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Name = var.instance_name
  }
}

