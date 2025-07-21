# -------------------------------------------------------
# Manages Aliases in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_firewall_alias" "proxy" {
  name    = "proxy"
  cidr    = "192.168.1.42"
  comment = "(Terraform) The proxy VM"
}

resource "proxmox_virtual_environment_firewall_alias" "plex" {
  name    = "plex"
  cidr    = "192.168.1.20"
  comment = "(Terraform) The plex VM"
}

resource "proxmox_virtual_environment_firewall_alias" "all" {
  name    = "all"
  cidr    = "0.0.0.0/0"
  comment = "(Terraform) Everywhere. All available IPs."
}

resource "proxmox_virtual_environment_firewall_alias" "vault_router" {
  name    = "vault_router"
  cidr    = "192.168.1.1"
  comment = "(Terraform) The IP address of the vault router. Usually used for DNS."
}
