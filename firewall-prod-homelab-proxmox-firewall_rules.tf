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
