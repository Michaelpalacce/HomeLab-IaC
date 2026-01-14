# -------------------------------------------------------
# Manages Security Groups in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_cluster_firewall_security_group" "prox-management" {
  name    = "prox-management"
  comment = "(Terraform) Proxmox nodes SG."

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow From Other Proxmox Instances"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.prox.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow From Management Devices"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow From K3S"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.k3s.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "DROP"
    comment = "(Terraform) Drop from all other places"
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
    comment = "(Terraform) Allow From Management Devices"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    macro   = "SSH"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.k3s.id}"
    comment = "(Terraform) Allow SSH from k3s to enable backups"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    macro   = "HTTP"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.cloudflare.id}"
    comment = "(Terraform) Allow HTTP traffic through from cloudflare proxies"
    log     = "nolog"

  }
  rule {
    type    = "in"
    action  = "ACCEPT"
    macro   = "HTTPS"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.cloudflare.id}"
    comment = "(Terraform) Allow HTTPS traffic through from cloudflare proxies"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "DROP"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.all.id}"
    comment = "(Terraform) Drop all other incoming"
    log     = "nolog"
  }

  rule {
    type    = "out"
    action  = "ACCEPT"
    macro   = "HTTP"
    dest    = "+dc/${proxmox_virtual_environment_firewall_ipset.public-lbs.id}"
    comment = "(Terraform) Allow HTTP access to the public Load Balancers"
    log     = "nolog"
  }

  rule {
    type    = "out"
    action  = "ACCEPT"
    macro   = "HTTPS"
    dest    = "+dc/${proxmox_virtual_environment_firewall_ipset.public-lbs.id}"
    comment = "(Terraform) Allow HTTPS access to the public Load Balancers"
    log     = "nolog"
  }

  rule {
    type    = "out"
    action  = "ACCEPT"
    comment = "(Terraform) Allow access to plex"
    proto   = "tcp"
    dest    = proxmox_virtual_environment_firewall_alias.plex.cidr
    dport   = "32400"
    log     = "nolog"
  }
}

resource "proxmox_virtual_environment_cluster_firewall_security_group" "plex" {
  name    = "plex"
  comment = "(Terraform) Special firewall rules for plex."

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow From Management Devices"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow From Management Devices"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.k3s.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Acept from internal TCP"
    proto   = "tcp"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.rfc-1918.id}"
    dport   = "32400"
    log     = "nolog"
  }
}

resource "proxmox_virtual_environment_cluster_firewall_security_group" "pingable" {
  name    = "pingable"
  comment = "(Terraform) Internally pingable."

  rule {
    type    = "in"
    action  = "ACCEPT"
    macro   = "Ping"
    comment = "(Terraform) Allows the resource to be pinged"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.rfc-1918.id}"
    log     = "nolog"
  }
}

resource "proxmox_virtual_environment_cluster_firewall_security_group" "no-comm-internal" {
  name    = "no-comm-internal"
  comment = "(Terraform) Prevent the vm from communicating out in the internal network."

  rule {
    type    = "out"
    action  = "ACCEPT"
    macro   = "DNS"
    comment = "(Terraform) Provides DNS to the resource"
    dest    = "dc/${proxmox_virtual_environment_firewall_alias.vault_router.id}"
    log     = "nolog"
  }

  rule {
    type    = "out"
    action  = "DROP"
    comment = "(Terraform) Reject ALL internal communicating based on rfc-1918"
    dest    = "+dc/${proxmox_virtual_environment_firewall_ipset.rfc-1918.id}"
    log     = "nolog"
  }
}

resource "proxmox_virtual_environment_cluster_firewall_security_group" "k3s" {
  name    = "k3s"
  comment = "(Terraform) K3S cluster permissions"

  rule {
    type    = "in"
    action  = "ACCEPT"
    macro   = "Ping"
    comment = "(Terraform) Makes the cluster pingable"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow connections from other k3s nodes."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.k3s.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow management access."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "DROP"
    comment = "(Terraform) Drop SSH"
    macro   = "SSH"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.all.id}"
    log     = "nolog"
  }

  # Make this accessible TCP/UDP on port 80/443

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow trusted devices access 80."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    proto   = "tcp"
    dport   = "80"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow trusted devices access 443."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    proto   = "tcp"
    dport   = "443"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow trusted devices access 80."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    proto   = "udp"
    dport   = "80"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow trusted devices access 443."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    proto   = "udp"
    dport   = "443"
    log     = "nolog"
  }

  # Make this accessible TCP/UDP on port 80/443

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow proxy access TCP."
    proto   = "tcp"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.proxy.id}"
    dport   = "80"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow proxy access TCP 443."
    proto   = "tcp"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.proxy.id}"
    dport   = "443"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow proxy access UDP."
    proto   = "udp"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.proxy.id}"
    dport   = "80"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "(Terraform) Allow proxy access UDP 443."
    proto   = "udp"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.proxy.id}"
    dport   = "443"
    log     = "nolog"
  }
}
