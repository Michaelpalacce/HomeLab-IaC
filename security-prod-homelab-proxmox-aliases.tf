# -------------------------------------------------------
# Manages Aliases in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_firewall_alias" "all" {
  name    = "all"
  cidr    = "0.0.0.0/0"
  comment = "(Terraform) Everywhere. All available IPs."
}

resource "proxmox_virtual_environment_firewall_alias" "sgenov_internal_lb" {
  name    = "sgenov-internal"
  cidr    = "192.168.1.15"
  comment = "(Terraform) Istio Internal sgenov.dev LB"
}

resource "proxmox_virtual_environment_firewall_alias" "sgenov_external_lb" {
  name    = "sgenov-external"
  cidr    = "192.168.1.16"
  comment = "(Terraform) Istio External sgenov.dev LB"
}

resource "proxmox_virtual_environment_firewall_alias" "replacedby_external_lb" {
  name    = "replacedby-external"
  cidr    = "192.168.1.17"
  comment = "(Terraform) Istio External replacedby.net LB"
}

resource "proxmox_virtual_environment_firewall_alias" "adygenova_external_lb" {
  name    = "adygenova-external"
  cidr    = "192.168.1.18"
  comment = "(Terraform) Istio External adygenova.com LB"
}

resource "proxmox_virtual_environment_firewall_alias" "proxy" {
  name    = "proxy"
  cidr    = "192.168.1.42"
  comment = "(Terraform) The proxy VM"
}

resource "proxmox_virtual_environment_firewall_alias" "tailscale" {
  name    = "tailscale"
  cidr    = "10.1.112.11"
  comment = "(Terraform) Tailscale VPN VM"
}

resource "proxmox_virtual_environment_firewall_alias" "plex" {
  name    = "plex"
  cidr    = "192.168.1.20"
  comment = "(Terraform) The plex VM"
}

resource "proxmox_virtual_environment_firewall_alias" "vault_router" {
  name    = "vault_router"
  cidr    = "192.168.1.1"
  comment = "(Terraform) The IP address of the vault router. Usually used for DNS."
}

###################
# Management Aliases
###################

resource "proxmox_virtual_environment_firewall_alias" "phone_wifi" {
  name    = "phone-wifi"
  cidr    = "10.1.0.169"
  comment = "(Terraform) Phone on wifi."
}

resource "proxmox_virtual_environment_firewall_alias" "macbook_air_m4" {
  name    = "macbook-air-m4"
  cidr    = "10.1.235.154"
  comment = "(Terraform) Macbook Air M4"
}

resource "proxmox_virtual_environment_firewall_alias" "pc_router" {
  name    = "pc-router"
  cidr    = "10.1.236.134"
  comment = "(Terraform) PC connected to router."
}

resource "proxmox_virtual_environment_firewall_alias" "management_backdoor" {
  name    = "management-backdoor"
  cidr    = "192.168.4.0/24"
  comment = "(Terraform) Management LAN. Dirrect connection to Vault Router on last port. This is a physical backdoor."
}

###################
# PROXMOX ALIASES
###################

resource "proxmox_virtual_environment_firewall_alias" "prox_1" {
  name    = "prox-1"
  cidr    = "192.168.1.200"
  comment = "(Terraform) prox-1.sgenov.dev"
}

resource "proxmox_virtual_environment_firewall_alias" "prox_2" {
  name    = "prox-2"
  cidr    = "192.168.1.201"
  comment = "(Terraform) prox-2-stefangenov.sgenov.dev"
}

resource "proxmox_virtual_environment_firewall_alias" "prox_3" {
  name    = "prox-3"
  cidr    = "192.168.1.202"
  comment = "(Terraform) prox-3.sgenov.dev"
}

resource "proxmox_virtual_environment_firewall_alias" "prox_4" {
  name    = "prox-4"
  cidr    = "192.168.1.203"
  comment = "(Terraform) prox-4.sgenov.dev - Not in use"
}

resource "proxmox_virtual_environment_firewall_alias" "prox_5" {
  name    = "prox-5"
  cidr    = "192.168.1.204"
  comment = "(Terraform) prox-5.sgenov.dev"
}


###################
# K3S Cluster
###################

resource "proxmox_virtual_environment_firewall_alias" "k3s_m1" {
  name    = "k3s-m1"
  cidr    = "192.168.1.78"
  comment = "(Terraform) k3s-m1"
}

resource "proxmox_virtual_environment_firewall_alias" "k3s_m2" {
  name    = "k3s-m2"
  cidr    = "192.168.1.83"
  comment = "(Terraform) k3s-m2"
}

resource "proxmox_virtual_environment_firewall_alias" "k3s_m3" {
  name    = "k3s-m3"
  cidr    = "192.168.1.242"
  comment = "(Terraform) k3s-m3"
}

resource "proxmox_virtual_environment_firewall_alias" "k3s_n1" {
  name    = "k3s-n1"
  cidr    = "192.168.1.89"
  comment = "(Terraform) k3s-n1"
}

resource "proxmox_virtual_environment_firewall_alias" "k3s_n2" {
  name    = "k3s-n2"
  cidr    = "192.168.1.55"
  comment = "(Terraform) k3s-n2"
}

resource "proxmox_virtual_environment_firewall_alias" "k3s_n3" {
  name    = "k3s-n3"
  cidr    = "192.168.1.247"
  comment = "(Terraform) k3s-n3"
}

resource "proxmox_virtual_environment_firewall_alias" "k3s_n5" {
  name    = "k3s-n5"
  cidr    = "192.168.1.79"
  comment = "(Terraform) k3s-n5"
}
