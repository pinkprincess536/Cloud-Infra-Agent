variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "sandbox"
}

variable "region" {
  description = "Existing deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "data_class" {
  description = "Data class handled by the workload"
  type        = string
  default     = "internal"
}

variable "rds_public_access" {
  description = "Whether the database has public network access"
  type        = bool
  default     = false
}

variable "ecs_module_version" {
  description = "Existing ECS module version recorded in the configuration"
  type        = string
  default     = "3.2.0"
}

variable "peak_docs_per_minute" {
  description = "Expected peak documents per minute"
  type        = number
  default     = 40
}

variable "max_file_size_mb" {
  description = "Maximum expected input file size"
  type        = number
  default     = 20
}
