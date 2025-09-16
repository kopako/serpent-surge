resource "aws_db_instance" "serpent-surge" {
  identifier          = "serpent-surge"
  instance_class      = "db.t3.micro"
  allocated_storage   = 5
  engine              = "mysql"
  engine_version      = "8.3"
  db_name             = var.db_name
  username            = var.db_user
  password_wo         = var.db_password
  password_wo_version = 1
  publicly_accessible = true
  skip_final_snapshot = true
}

