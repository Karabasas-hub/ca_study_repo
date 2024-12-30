variable "db_username" {
    description = "Database administrator username"
    type = string
    sensitive = true
    default = "admin"
}

variable "db_password" {
    description = "Database administrator password"
    type = string
    sensitive = true
    default = "nelabaigerasslaptazodis"
}
variable "project_name" {
    description = "Name of the project"
    type        = string
    default     = "my-project"
}

variable "environment" {
    description = "Name of environment"
    type        = string
    default     = "dev"
}
variable "resource_tags" {
    description = "Tags to set for all resources"
    type        = map(string)
    default = {}
}

variable "avz" {
    default = ["eu-central-1a", "eu-central-1b"]
}