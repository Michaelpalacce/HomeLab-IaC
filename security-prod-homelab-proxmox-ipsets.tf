# -------------------------------------------------------
# Manages IPSets in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_firewall_ipset" "trusted" {
  name    = "trusted"
  comment = "(Terraform) Trusted Networks, rfc-1918 networks, but only the ones that are trusted and used by humans."

  cidr {
    name    = "10.1.0.0/16"
    comment = "Home Lan Network. This is the default WIFI network."
  }

  cidr {
    name    = "192.168.0.0/16"
    comment = "Vault. This is the internal Vault network"
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
    name    = "192.168.1.10"
    comment = "Excalidraw. Dashboard for drawing."
  }
  cidr {
    name    = "192.168.1.11"
    comment = "It-Tools. Helpful tools for it administration."
  }
  cidr {
    name    = "192.168.1.12"
    comment = "Cyberchef. Helpful tools for it administration."
  }
  cidr {
    name    = "192.168.1.13"
    comment = "Mealie. Self-hosted recipies."
  }
  cidr {
    name    = "192.168.1.14"
    comment = "Niolesk. Kroki diagrams."
  }
  cidr {
    name    = "192.168.1.15"
    comment = "Kavita. Books!!!."
  }
  cidr {
    name    = "192.168.1.6"
    comment = "My website. sgenov.dev"
  }
  cidr {
    name    = "192.168.1.7"
    comment = "Wallabag. Self hosted pocket alternative."
  }
  cidr {
    name    = "192.168.1.8"
    comment = "Paperless-NGX. For document storage."
  }
  cidr {
    name    = "192.168.1.9"
    comment = "Firefly. Budgeting software."
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "manage" {
  name    = "manage"
  comment = "(Terraform) Holds the management IPs. Devices that have administrator permissions."

  cidr {
    name    = "10.1.0.169"
    comment = "Phone on wifi."
  }

  cidr {
    name    = "10.1.235.154"
    comment = "Macbook Air M4"
  }

  cidr {
    name    = "10.1.236.134"
    comment = "PC connected to router."
  }

  cidr {
    name    = "192.168.4.0/24"
    comment = "Management LAN. Dirrect connection to Vault Router on last port. This is a physical backdoor."
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "prox" {
  name    = "prox"
  comment = "(Terraform) Holds the proxmox cluster IPs"

  cidr {
    name    = "192.168.1.200"
    comment = "prox-1.sgenov.dev"
  }

  cidr {
    name    = "192.168.1.201"
    comment = "prox-2.sgenov.dev"
  }

  cidr {
    name    = "192.168.1.202"
    comment = "prox-3.sgenov.dev"
  }

  # This is not in use
  cidr {
    name    = "192.168.1.203"
    comment = "prox-4.sgenov.dev"
  }

  cidr {
    name    = "192.168.1.204"
    comment = "prox-5.sgenov.dev"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "proxmox_virtual_environment_firewall_ipset" "k3s" {
  name    = "k3s"
  comment = "(Terraform) Holds all the IPs of the VMs where k3s will be installeHolds all the IPs of the VMs where k3s will be installed"

  cidr {
    name    = module.k3s_vms["k3s-m3"].vm_ipv4_address
    comment = module.k3s_vms["k3s-m3"].vm_name
  }

  cidr {
    name    = module.k3s_vms["k3s-n3"].vm_ipv4_address
    comment = module.k3s_vms["k3s-n3"].vm_name
  }

  cidr {
    name    = module.k3s_vms["k3s-n2"].vm_ipv4_address
    comment = module.k3s_vms["k3s-n2"].vm_name
  }

  cidr {
    name    = module.k3s-n5.vm_ipv4_address
    comment = module.k3s-n5.vm_name
  }

  cidr {
    name    = module.k3s_vms["k3s-m1"].vm_ipv4_address
    comment = module.k3s_vms["k3s-m1"].vm_name
  }

  cidr {
    name    = module.k3s_vms["k3s-m2"].vm_ipv4_address
    comment = module.k3s_vms["k3s-m2"].vm_name
  }

  cidr {
    name    = module.k3s_vms["k3s-n1"].vm_ipv4_address
    comment = module.k3s_vms["k3s-n1"].vm_name
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
