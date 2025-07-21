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

resource "proxmox_virtual_environment_firewall_rules" "k3s_nodes" {
  for_each = {
    "k3s-m1" = module.k3s_vms["k3s-m1"]
    "k3s-n1" = module.k3s_vms["k3s-n1"]

    "k3s-m2" = module.k3s_vms["k3s-m2"]
    "k3s-n2" = module.k3s_vms["k3s-n2"]

    "k3s-m3" = module.k3s_vms["k3s-m3"]
    "k3s-n3" = module.k3s_vms["k3s-n3"]

    "k3s-n5" = module.k3s-n5
  }

  node_name = each.value.node_name
  vm_id     = each.value.vm_id

  rule {
    security_group = proxmox_virtual_environment_cluster_firewall_security_group.k3s.name
    comment        = "(Terraform) k3s specific settings for ${each.key}."
  }
}
