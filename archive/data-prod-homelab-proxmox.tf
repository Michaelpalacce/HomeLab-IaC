data "proxmox_virtual_environment_vm" "plex" {
  node_name = data.proxmox_virtual_environment_node.prox-5.node_name
  vm_id     = 104
}

data "proxmox_virtual_environment_vm" "proxy" {
  node_name = data.proxmox_virtual_environment_node.prox-5.node_name
  vm_id     = 107
}

data "proxmox_virtual_environment_vm" "tailscale" {
  node_name = data.proxmox_virtual_environment_node.prox-5.node_name
  vm_id     = 108
}
