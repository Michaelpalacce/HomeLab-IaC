output "vm_ipv4_address" {
  value       = proxmox_virtual_environment_vm.k3s_vm.ipv4_addresses[1][0]
  description = "IP of VM:"
}
