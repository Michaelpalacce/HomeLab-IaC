# -------------------------------------------------------
# Manages Repos in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_apt_standard_repository" "prox-1-no-subscription" {
  node   = data.proxmox_virtual_environment_node.prox-1.id
  handle = "no-subscription"
}

resource "proxmox_virtual_environment_apt_standard_repository" "prox-2-no-subscription" {
  node   = data.proxmox_virtual_environment_node.prox-2.id
  handle = "no-subscription"
}

resource "proxmox_virtual_environment_apt_standard_repository" "prox-3-no-subscription" {
  node   = data.proxmox_virtual_environment_node.prox-3.id
  handle = "no-subscription"
}

resource "proxmox_virtual_environment_apt_standard_repository" "prox-5-no-subscription" {
  node   = data.proxmox_virtual_environment_node.prox-5.id
  handle = "no-subscription"
}
