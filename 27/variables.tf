variable resource_group_name {
  type        = string
  default     = ""
  description = "Resource Group Name"
}

variable region {
  type        = string
  default     = "polandcentral"
  description = "Region for the infrastructure"
  validation {
    condition = contains(["northeurope", "norwayeast", "polandcentral"], var.region)
    error_message = "Value can only contain northeurope, norwayeast and polandcentral. We dont like westerners"
  }
}

variable virtual_network_name {
  type        = string
  default     = ""
  description = "Virtual Network Name"
}

variable subnet_name {
  type        = string
  default     = ""
  description = "Name of the subnet"
}

variable vm_name {
  type        = string
  default     = ""
  description = "virtual Machine name"
}

variable machine_size {
  type        = string
  default     = "Standard_B1s"
  description = "VM size"
  validation {
    condition = contains(["Standard_B1ls","Standard_B1ms","Standard_B1s"], var.machine_size)
    error_message = "Value can contain only Standard_B1ls,Standard_B1ms,Standard_B1s"
  }
}

variable public_key {
  type        = string
  default     = ""
  description = "the ssh key to setup vm"
}