resource "aws_instance" "serpent_surge_app_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.ssh_keypair
  vpc_security_group_ids = [aws_security_group.web_server.id]
  iam_instance_profile = aws_iam_instance_profile.this.name

  tags = {
    Name = var.instance_name
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web_server" {
  name        = "serpent_surge_web_server_sg"
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

resource "aws_iam_role" "ec2_role" {
  name = "${var.instance_name}_ec2_role"

  assume_role_policy = data.aws_iam_policy_document.ec2_role.json

  tags = {
    Name = var.instance_name
  }
}

resource "aws_iam_policy" "s3_access_policy" {
  name = "EC2S3AccessPolicy"

  policy = data.aws_iam_policy_document.s3_role.json
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.instance_name}_ec2_role"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name = var.instance_name
  }
}