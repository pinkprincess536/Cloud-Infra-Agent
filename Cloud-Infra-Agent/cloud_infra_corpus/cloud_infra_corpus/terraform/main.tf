terraform {
  required_version = ">= 1.5.0"
}

# Synthetic HCL fixture. The module_version fields intentionally record the
# version of the deployed/configured module so an agent can compare it with
# the dated platform handbook approval.

module "network" {
  source = "./modules/network"

  region      = var.region
  environment = var.environment
  tags = {
    service     = "document-processor"
    owner       = "billing-platform"
    environment = var.environment
    cost-center = "FIN-42"
    data-class  = var.data_class
  }
}

module "api" {
  source = "./modules/ecs-service"

  name           = "document-processor-api"
  module_version = var.ecs_module_version
  container_port  = 8000
  health_path     = "/health"
  public_ingress  = true
  worker          = false
}

module "worker" {
  source = "./modules/ecs-service"

  name           = "document-processor-worker"
  module_version = var.ecs_module_version
  container_port  = 8000
  health_path     = "/health"
  public_ingress  = false
  worker          = true
}

module "database" {
  source = "./modules/rds-postgres"

  name          = "document-processor-db"
  engine        = "postgres"
  engine_major  = "16"
  public_access = var.rds_public_access
  multi_az      = var.environment == "production"
  deletion_protection = var.environment == "production"
}

module "documents" {
  source = "./modules/s3-bucket"

  name = "document-processor-documents"
  kms_encryption = true
}

module "jobs" {
  source = "./modules/sqs"

  name                       = "document-processing-jobs"
  visibility_timeout_seconds = 300
  max_receive_count          = 3
}
