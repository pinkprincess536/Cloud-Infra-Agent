variable "region" { type = string }
variable "environment" { type = string }
variable "tags" { type = map(string) }
resource "terraform_data" "network" {
  input = { region = var.region, environment = var.environment, tags = var.tags }
}
