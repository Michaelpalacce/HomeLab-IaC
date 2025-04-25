# -------------------------------------------------------
# Manages Security Groups in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_cluster_firewall_security_group" "vpn" {
  name    = "vpn"
  comment = "(Terraform) Allows vpned devices to only access certain things"

  rule {
    type    = "out"
    action  = "ACCEPT"
    proto   = "udp"
    comment = "Allow HTTP"
    dest    = "dc/${proxmox_virtual_environment_firewall_alias.plex.id}"
    dport   = "32400"
    log     = "nolog"
  }

  rule {
    type    = "out"
    action  = "ACCEPT"
    proto   = "tcp"
    comment = "Allow HTTP"
    dest    = "dc/${proxmox_virtual_environment_firewall_alias.plex.id}"
    dport   = "32400"
    log     = "nolog"
  }
}

resource "proxmox_virtual_environment_cluster_firewall_security_group" "prox-management" {
  name    = "prox-management"
  comment = "(Terraform) Accept communication IN only from proxmox management."

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow From Other Proxmox Instances"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.prox.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow From Management Devices"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "DROP"
    comment = "Drop from all other places"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.all.id}"
    log     = "nolog"
  }
}

