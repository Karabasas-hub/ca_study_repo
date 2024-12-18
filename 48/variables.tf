variable "aws_region" {
    description = "AWS region"
    default     = "eu-central-1"
}

variable "cidr_block" {
    description = "Base CDIR block for VPC"
    default     = "10.0.0.0/16"
}

variable "environment" {
    description = "Deployment environment"
    type        = string
    default     = "dev"
}

variable "machine_type" {
    description = "Instance type (choose one: t2.micro, t3.micro, t3.small)"
    type = string
    validation {
        condition     = contains(["t2.micro", "t3.micro", "t3.small"], var.machine_type)
        error_message = "Machine type must be selected out of the provided ones"
    }
}

variable "key_name" {
    description = "AWS key pair name for SSH"
    type        = string
    default     = "48_vm_key"
}

variable "public_key_path" {
    description = "absolute path to ssh key"
    type        = string
    default     = "~/ca_repo/ca_study_repo/48"
}

