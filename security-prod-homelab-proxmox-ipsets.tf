# -------------------------------------------------------
# Manages IPSets in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_firewall_ipset" "trusted" {
  name    = "trusted"
  comment = "(Terraform) Trusted Networks, rfc-1918 networks, but only the ones that are trusted and used by humans."

  cidr {
    name    = "10.1.0.0/16"
    comment = "(Terraform) Home Lan Network. This is the default WIFI network."
  }

  cidr {
    name    = "192.168.0.0/16"
    comment = "(Terraform) Vault. This is the internal Vault network"
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "rfc-1918" {
  name    = "rfc-1918"
  comment = "(Terraform) All addressed outlined in RFC-1918: https://datatracker.ietf.org/doc/html/rfc1918"

  cidr {
    name = "10.0.0.0/8"
  }

  cidr {
    name = "172.16.0.0/12"
  }

  cidr {
    name = "192.168.0.0/16"
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "public-lbs" {
  name    = "public-lbs"
  comment = "(Terraform) The LBs that the proxy VM communicates with."

  # Order is important, otherwise will force replacement
  cidr {
    name    = proxmox_virtual_environment_firewall_alias.sgenov_external_lb.cidr
    comment = "(Terraform) sgenov.dev"
  }
  cidr {
    name    = proxmox_virtual_environment_firewall_alias.replacedby_external_lb.cidr
    comment = "(Terraform) replacedby.net"
  }
  cidr {
    name    = proxmox_virtual_environment_firewall_alias.adygenova_external_lb.cidr
    comment = "(Terraform) adygenova.com"
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "prox" {
  name    = "prox"
  comment = "(Terraform) Holds the proxmox cluster IPs"

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.prox_1.cidr
    comment = "(Terraform) prox-1.sgenov.dev"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.prox_2.cidr
    comment = "(Terraform) prox-2-stefangenov.sgenov.dev"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.prox_3.cidr
    comment = "(Terraform) prox-3.sgenov.dev"
  }

  # This is not in use
  cidr {
    name    = proxmox_virtual_environment_firewall_alias.prox_4.cidr
    comment = "(Terraform) prox-4.sgenov.dev"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.prox_5.cidr
    comment = "(Terraform) prox-5.sgenov.dev"
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "manage" {
  name    = "manage"
  comment = "(Terraform) Holds the management IPs. Devices that have administrator permissions."

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.phone_wifi.cidr
    comment = "(Terraform) Phone on wifi."
  }

  # cidr {
  #   name    = proxmox_virtual_environment_firewall_alias.tailscale.cidr
  #   comment = "(Terraform) Raspberry-pi zero 2w Tailscale"
  # }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.macbook_air_m4.cidr
    comment = "(Terraform) Macbook Air M4"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.pc_router.cidr
    comment = "(Terraform) PC connected to router."
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.management_backdoor.cidr
    comment = "(Terraform) Management LAN. Dirrect connection to Vault Router on last port. This is a physical backdoor."
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "k3s" {
  name    = "k3s"
  comment = "(Terraform) Holds all the IPs of the VMs where k3s will be installeHolds all the IPs of the VMs where k3s will be installed"

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.k3s_m1.cidr
    comment = "(Terraform) k3s-m1"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.k3s_m2.cidr
    comment = "(Terraform) k3s-m2"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.k3s_m3.cidr
    comment = "(Terraform) k3s-m3"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.k3s_n1.cidr
    comment = "k3s-n1"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.k3s_n2.cidr
    comment = "(Terraform) k3s-n2"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.k3s_n3.cidr
    comment = "(Terraform) k3s-n3"
  }

  cidr {
    name    = proxmox_virtual_environment_firewall_alias.k3s_n5.cidr
    comment = "(Terraform) k3s-n5"
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "cloudflare" {
  name    = "cloudflare"
  comment = "(Terraform) Holds the publicly avialable cloudflare IPs. https://www.cloudflare.com/ips-v4"

  cidr { name = "103.21.244.0/22" }
  cidr { name = "103.22.200.0/22" }
  cidr { name = "103.31.4.0/22" }
  cidr { name = "104.16.0.0/13" }
  cidr { name = "104.24.0.0/14" }
  cidr { name = "108.162.192.0/18" }
  cidr { name = "131.0.72.0/22" }
  cidr { name = "141.101.64.0/18" }
  cidr { name = "162.158.0.0/15" }
  cidr { name = "172.64.0.0/13" }
  cidr { name = "173.245.48.0/20" }
  cidr { name = "188.114.96.0/20" }
  cidr { name = "190.93.240.0/20" }
  cidr { name = "197.234.240.0/22" }
  cidr { name = "198.41.128.0/17" }
}
