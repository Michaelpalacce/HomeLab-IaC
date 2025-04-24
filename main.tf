terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token

  insecure = false
  tmp_dir  = "/var/tmp"

  ssh {
    agent    = true
    username = var.proxmox_ssh_username
    password = var.proxmox_ssh_password
  }
}

