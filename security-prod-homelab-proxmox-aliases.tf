# -------------------------------------------------------
# Manages Aliases in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_firewall_alias" "cluster-lb" {
  name    = "cluster-lb"
  cidr    = "192.168.1.5"
  comment = "(Terraform) The K3S Internal LB"
}

resource "proxmox_virtual_environment_firewall_alias" "proxy" {
  name    = "proxy"
  cidr    = "192.168.1.42"
  comment = "(Terraform) The proxy VM"
}

resource "proxmox_virtual_environment_firewall_alias" "tailscale" {
  name    = "tailscale"
  cidr    = "192.168.1.22"
  comment = "(Terraform) Tailscale VPN VM"
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
