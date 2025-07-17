# -------------------------------------------------------
# Manages IPSets in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_firewall_rules" "plex" {
  depends_on = [
    data.proxmox_virtual_environment_vm.plex,
  ]

  node_name = data.proxmox_virtual_environment_vm.plex.node_name
  vm_id     = data.proxmox_virtual_environment_vm.plex.vm_id

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.plex.name
    comment        = "(Terraform) plex specific settings."
  }

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.no-comm-internal.name
    comment        = "(Terraform) Forbid all internal communications."
  }
}

resource "proxmox_virtual_environment_firewall_rules" "proxy" {
  depends_on = [
    data.proxmox_virtual_environment_vm.proxy,
  ]

  node_name = data.proxmox_virtual_environment_vm.proxy.node_name
  vm_id     = data.proxmox_virtual_environment_vm.proxy.vm_id

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.proxy.name
    comment        = "(Terraform) proxy specific settings."
  }

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.no-comm-internal.name
    comment        = "(Terraform) Forbid all internal communications."
  }
}

resource "proxmox_virtual_environment_firewall_rules" "tailscale" {
  depends_on = [
    data.proxmox_virtual_environment_vm.tailscale,
  ]

  node_name = data.proxmox_virtual_environment_vm.tailscale.node_name
  vm_id     = data.proxmox_virtual_environment_vm.tailscale.vm_id

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.pingable.name
    comment        = "(Terraform) Allow the VM to be pinged."
  }

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.prox-management.name
    comment        = "(Terraform) Allow full access from management."
  }

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.vpn.name
    comment        = "(Terraform) vpn specific settings."
  }

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.no-comm-internal.name
    comment        = "(Terraform) Forbid all internal communications."
  }
}

locals {
  k3s_nodes = {
    "k3s-m1" = {
      node_name = "prox-1"
      vm_id     = 100
    },
    "k3s-n1" = {
      node_name = "prox-1"
      vm_id     = 101
    },
    "k3s-m2" = {
      node_name = "prox-2-stefangenov"
      vm_id     = 102
    },
    "k3s-n2" = {
      node_name = "prox-2-stefangenov"
      vm_id     = 106
    },
    "k3s-m3" = {
      node_name = "prox-3"
      vm_id     = 103
    },
    "k3s-n3" = {
      node_name = "prox-3"
      vm_id     = 105
    },
  }
}

data "proxmox_virtual_environment_vm" "k3s_node" {
  for_each  = local.k3s_nodes
  node_name = each.value.node_name
  vm_id     = each.value.vm_id
}

resource "proxmox_virtual_environment_firewall_rules" "k3s_node" {
  for_each = data.proxmox_virtual_environment_vm.k3s_node

  depends_on = [
    data.proxmox_virtual_environment_vm.k3s_node
  ]

  node_name = each.value.node_name
  vm_id     = each.value.vm_id

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.k3s.name
    comment        = "(Terraform) k3s specific settings."
  }
}
