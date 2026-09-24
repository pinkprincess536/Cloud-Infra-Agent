variable "name" { type = string }
variable "engine" { type = string }
variable "engine_major" { type = string }
variable "public_access" { type = bool }
variable "multi_az" { type = bool }
variable "deletion_protection" { type = bool }
resource "terraform_data" "database" {
  input = { name = var.name, engine = var.engine, engine_major = var.engine_major, public_access = var.public_access, multi_az = var.multi_az, deletion_protection = var.deletion_protection }
}
