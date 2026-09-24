variable "name" { type = string }
variable "module_version" { type = string }
variable "container_port" { type = number }
variable "health_path" { type = string }
variable "public_ingress" { type = bool }
variable "worker" { type = bool }
resource "terraform_data" "service" {
  input = { name = var.name, module_version = var.module_version, container_port = var.container_port, health_path = var.health_path, public_ingress = var.public_ingress, worker = var.worker }
}
