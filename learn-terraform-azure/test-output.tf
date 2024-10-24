output "vm_name" {
  value = azurerm_linux_virtual_machine.test-VM.name
}
output "private_ip_adress" {
  value = azurerm_linux_virtual_machine.test-VM.private_ip_address
}
output "location" {
  value = azurerm_linux_virtual_machine.test-VM.location
}
