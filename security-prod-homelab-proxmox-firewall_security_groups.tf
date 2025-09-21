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

  rule {
    type    = "out"
    action  = "ACCEPT"
    comment = "Allow to internal LB"
    dest    = "dc/${proxmox_virtual_environment_firewall_alias.cluster-lb.id}"
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

  lifecycle {
    prevent_destroy = true
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
    comment = "Acept from internal TCP"
    proto   = "tcp"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    dport   = "32400"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Acept from internal UDP"
    proto   = "udp"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
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
    comment = "Allows the resource to be pinged"
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
    comment = "Provides DNS to the resource"
    dest    = "dc/${proxmox_virtual_environment_firewall_alias.vault_router.id}"
    log     = "nolog"
  }

  rule {
    type    = "out"
    action  = "DROP"
    comment = "Reject ALL internal communicating based on rfc-1918"
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
    comment = "Makes the cluster pingable"
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow connections from other k3s nodes."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.k3s.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow management access."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.manage.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "DROP"
    comment = "Drop SSH"
    macro   = "SSH"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.all.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow trusted devices access."
    source  = "+dc/${proxmox_virtual_environment_firewall_ipset.trusted.id}"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow proxy access TCP."
    proto   = "tcp"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.proxy.id}"
    dport   = "80"
    log     = "nolog"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "Allow proxy access UDP."
    proto   = "udp"
    source  = "dc/${proxmox_virtual_environment_firewall_alias.proxy.id}"
    dport   = "80"
    log     = "nolog"
  }
}
