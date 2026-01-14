# -------------------------------------------------------
# Manages firewall on the VM level
# -------------------------------------------------------

resource "proxmox_virtual_environment_firewall_options" "plex" {
  depends_on = [
    data.proxmox_virtual_environment_vm.plex,
  ]

  node_name = data.proxmox_virtual_environment_vm.plex.node_name
  vm_id     = data.proxmox_virtual_environment_vm.plex.vm_id

  enabled       = true
  dhcp          = true
  ndp           = true
  radv          = false
  macfilter     = true
  ipfilter      = false
  log_level_in  = "nolog"
  log_level_out = "nolog"

  input_policy  = "DROP"
  output_policy = "ACCEPT"
}

resource "proxmox_virtual_environment_firewall_options" "proxy" {
  depends_on = [
    data.proxmox_virtual_environment_vm.proxy,
  ]

  node_name = data.proxmox_virtual_environment_vm.proxy.node_name
  vm_id     = data.proxmox_virtual_environment_vm.proxy.vm_id

  enabled       = true
  dhcp          = true
  ndp           = true
  radv          = false
  macfilter     = true
  ipfilter      = false
  log_level_in  = "nolog"
  log_level_out = "nolog"

  input_policy  = "DROP"
  output_policy = "ACCEPT"
}


resource "proxmox_virtual_environment_firewall_options" "k3s_vms" {
  for_each = data.proxmox_virtual_environment_vm.k3s_vms

  node_name = each.value.node_name
  vm_id     = each.value.vm_id

  enabled       = true
  dhcp          = true
  ndp           = true
  radv          = false
  macfilter     = true
  ipfilter      = false
  log_level_in  = "nolog"
  log_level_out = "nolog"

  input_policy  = "DROP"
  output_policy = "ACCEPT"
}
