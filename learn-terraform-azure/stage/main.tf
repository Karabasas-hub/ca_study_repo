variable environment { 
    type = string 
    default = "stage"
}

module {
    source = "../modules/VM"
    region = "northeurope"
    resource_group_name = "stage_rsgp"
    virtual_network_name = "stage_vpc"
    subnet_name = "stagesubnet"
    vm_name = "${var.environment}-catest001"
    machine_size = "Standard_B1s"
}