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
  comment = "(Terraform) Proxmox nodes SG."

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

resource "proxmox_virtual_environment_cluster_firewall_security_group" "proxy" {
  name    = "proxy"
  comment = "(Terraform) Special Rules for `proxy` VM. The VM is exposed, so we need to make sure it's safe."

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow From Management Devices"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    proto   = "tcp"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.k3s.id}"
    comment = "Allow SSH from k3s to enable backups"
    dport   = "22"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    macro   = "HTTPS"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.cloudflare.id}"
    comment = "Allow HTTPS traffic through from cloudflare proxies"
    log     = "nolog"
  }

  # rule {
  #   type    = "in"
  #   action  = "ACCEPT"
  #   macro   = "HTTP"
  #   source  = "+dc/${proxmox_virtual_environment_firewall_ipset.cloudflare.id}"
  #   comment = "Allow HTTPS traffic through from cloudflare proxies"
  #   log     = "nolog"
  # }

  rule {
    type    = "in"
    action  = "DROP"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.all.id}"
    comment = "Drop all other incoming"
    log     = "nolog"
  }

  # rule {
  #   type    = "out"
  #   action  = "ACCEPT"
  #   macro   = "HTTPS"
  #   dest    = "+dc/${proxmox_virtual_environment_firewall_ipset.public-lbs.id}"
  #   comment = "Allow access to the public Load Balancers"
  #   log     = "nolog"
  # }

  rule {
    type    = "out"
    action  = "ACCEPT"
    macro   = "HTTP"
    dest    = "+dc/${proxmox_virtual_environment_firewall_ipset.public-lbs.id}"
    comment = "Allow access to the public Load Balancers"
    log     = "nolog"
  }
}


resource "proxmox_virtual_environment_cluster_firewall_security_group" "plex" {
  name    = "plex"
  comment = "(Terraform) Special firewall rules for plex."

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow From Management Devices"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Acept from internal"
    proto   = "tcp"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.rfc-1918.id}"
    dport   = "32400"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Acept from internal"
    proto   = "udp"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.rfc-1918.id}"
    dport   = "32400"
    log     = "nolog"
  }
}
