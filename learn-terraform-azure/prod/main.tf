variable environment { 
    type = string 
    default = "prod"
}

module {
    source = "../modules/VM"
    region = "northeurope"
    resource_group_name = "prod_rsgp"
    virtual_network_name = "prod_vpc"
    subnet_name = "prodsubnet"
    vm_name = "${var.environment}-catest001"
    machine_size = "Standard_B1s"
}