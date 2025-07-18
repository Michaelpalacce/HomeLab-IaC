# -------------------------------------------------------
# Manages IPSets in Proxmox
# -------------------------------------------------------


data "proxmox_virtual_environment_node" "prox-1" {
  node_name = "prox-1"
}

data "proxmox_virtual_environment_node" "prox-2" {
  # Yes, I know...
  node_name = "prox-2-stefangenov"
}

data "proxmox_virtual_environment_node" "prox-3" {
  node_name = "prox-3"
}

data "proxmox_virtual_environment_node" "prox-5" {
  node_name = "prox-5"
}

data "proxmox_virtual_environment_vm" "k3s-m1" {
  node_name = data.proxmox_virtual_environment_node.prox-1.node_name
  vm_id     = 100
}

data "proxmox_virtual_environment_vm" "k3s-n1" {
  node_name = data.proxmox_virtual_environment_node.prox-1.node_name
  vm_id     = 101
}

data "proxmox_virtual_environment_vm" "k3s-m2" {
  node_name = data.proxmox_virtual_environment_node.prox-2.node_name
  vm_id     = 102
}

data "proxmox_virtual_environment_vm" "k3s-n2" {
  node_name = data.proxmox_virtual_environment_node.prox-2.node_name
  vm_id     = 106
}

data "proxmox_virtual_environment_vm" "k3s-m3" {
  node_name = data.proxmox_virtual_environment_node.prox-3.node_name
  vm_id     = 103
}

data "proxmox_virtual_environment_vm" "k3s-n3" {
  node_name = data.proxmox_virtual_environment_node.prox-3.node_name
  vm_id     = 105
}

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
