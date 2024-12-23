variable "db_username" {
    description = "Database administrator username"
    type = string
    sensitive = true
}

variable "db_password" {
    description = "Database administrator password"
    type = string
    sensitive = true
}

variable "resource_tags" {
    description = "Tags to set for all resources"
    type        = map(string)
    default = {}
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