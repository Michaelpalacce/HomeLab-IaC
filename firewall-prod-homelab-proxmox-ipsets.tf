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
    name    = "172.16.0.0/12"
    comment = "WIFIman. This is how I VPN in."
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
