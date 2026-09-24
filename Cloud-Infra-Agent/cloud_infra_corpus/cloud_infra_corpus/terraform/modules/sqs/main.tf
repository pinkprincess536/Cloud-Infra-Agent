variable "name" { type = string }
variable "visibility_timeout_seconds" { type = number }
variable "max_receive_count" { type = number }
resource "terraform_data" "queue" {
  input = { name = var.name, visibility_timeout_seconds = var.visibility_timeout_seconds, max_receive_count = var.max_receive_count }
}
