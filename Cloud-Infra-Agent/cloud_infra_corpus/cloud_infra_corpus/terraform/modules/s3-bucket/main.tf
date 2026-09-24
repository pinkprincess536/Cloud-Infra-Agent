variable "name" { type = string }
variable "kms_encryption" { type = bool }
resource "terraform_data" "bucket" {
  input = { name = var.name, kms_encryption = var.kms_encryption }
}
