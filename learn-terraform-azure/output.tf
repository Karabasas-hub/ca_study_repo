output "vm_name" {
  value = azurerm_linux_virtual_machine.example.name
}  
output "private_ip_adress" {
  value = azurerm_linux_virtual_machine.example.private_ip_address
}
