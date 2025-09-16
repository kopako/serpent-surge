variable "db_password" {
  description = "RDS user password"
  sensitive   = true
  ephemeral = true
}

variable "db_user" {
  default = "node_user"
}

variable "db_name" {
  default = "serpent_surge_db"
}