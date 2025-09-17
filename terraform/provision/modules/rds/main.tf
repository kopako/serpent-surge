data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "db" {
  name        = "serpent-surge-db-sg"
  description = "Allow HTTPS to web server"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "allow_mysql" {
  type              = "ingress"
  description       = "HTTPS ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default.cidr_block]
  security_group_id = aws_security_group.db.id
}

resource "aws_db_instance" "serpent-surge" {
  identifier             = "serpent-surge"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "8.0"
  db_name                = var.db_name
  username               = var.db_user
  password_wo            = var.db_password
  vpc_security_group_ids = [aws_security_group.db.id]
  password_wo_version    = 1
  publicly_accessible    = true
  skip_final_snapshot    = true
}

