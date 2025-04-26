# -------------------------------------------------------
# Manages Repos in Proxmox
# -------------------------------------------------------

resource "proxmox_virtual_environment_acme_dns_plugin" "Cloudflare" {
  plugin           = "Cloudflare"
  api              = "cf"
  validation_delay = 30
  data = {
    CF_Email = "stefantigro@gmail.com"
    CF_Key   = var.cloudflare_api_key
  }
}
