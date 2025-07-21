output "vm_ipv4_address" {
  value       = proxmox_virtual_environment_vm.k3s_vm.ipv4_addresses[1][0]
  description = "IP of VM:"
}

output "vm_id" {
  value       = proxmox_virtual_environment_vm.k3s_vm.vm_id
  description = "The VM's ID"
}

output "node_name" {
  value       = proxmox_virtual_environment_vm.k3s_vm.node_name
  description = "The VM node's name"
}
