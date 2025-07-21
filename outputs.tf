output "k3s-n5_ipv4_address" {
  value = module.k3s-n5.vm_ipv4_address
}

# output "k3s_m1_ipv4_address" {
#   value = module.k3s-vms["k3s-m1"].vm_ipv4_addresses
# }
#
# output "k3s_n1_ipv4_address" {
#   value = proxmox_virtual_environment_vm.k3s_vms["k3s-n1"].ipv4_addresses[1][0]
# }
#
# output "k3s_m2_ipv4_address" {
#   value = proxmox_virtual_environment_vm.k3s_vms["k3s-m2"].ipv4_addresses[1][0]
# }
#
# output "k3s_n2_ipv4_address" {
#   value = proxmox_virtual_environment_vm.k3s_vms["k3s-n2"].ipv4_addresses[1][0]
# }
#
# output "k3s_m3_ipv4_address" {
#   value = proxmox_virtual_environment_vm.k3s_vms["k3s-m3"].ipv4_addresses[1][0]
# }
#
# output "k3s_n3_ipv4_address" {
#   value = proxmox_virtual_environment_vm.k3s_vms["k3s-n3"].ipv4_addresses[1][0]
# }
