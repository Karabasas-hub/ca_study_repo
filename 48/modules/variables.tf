variable "ec2_count" {
    default = 3
}

variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "security_group_ids" {
    type = list(string)
}
variable "environment" {}