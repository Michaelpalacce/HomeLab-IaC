# -------------------------------------------------------
# Manages Security Groups in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_cluster_firewall" "sgenov" {
  enabled = false

  ebtables      = true
  input_policy  = "DROP"
  output_policy = "ACCEPT"
  log_ratelimit {
    enabled = true
    burst   = 5
    rate    = "1/second"
  }
}
