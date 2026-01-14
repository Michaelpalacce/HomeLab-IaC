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

locals {
  k3s_nodes = {
    "k3s-m1" = { node = "prox-1", id = 100 }
    "k3s-n1" = { node = "prox-1", id = 101 }

    "k3s-m2" = { node = "prox-2-stefangenov", id = 102 }
    "k3s-n2" = { node = "prox-2-stefangenov", id = 106 }

    "k3s-m3" = { node = "prox-3", id = 103 }
    "k3s-n3" = { node = "prox-3", id = 105 }

    "k3s-n5" = { node = "prox-5", id = 109 }
  }
}

data "proxmox_virtual_environment_vm" "k3s_vms" {
  for_each = local.k3s_nodes

  node_name = each.value.node
  vm_id     = each.value.id
}

data "proxmox_virtual_environment_vm" "plex" {
  node_name = "prox-5"
  vm_id     = "104"
}

data "proxmox_virtual_environment_vm" "proxy" {
  node_name = "prox-5"
  vm_id     = "107"
}
