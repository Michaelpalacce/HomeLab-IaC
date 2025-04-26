variable "proxmox_endpoint" {
  type        = string
  sensitive   = false
  nullable    = false
  description = "The Proxmox VE endpoint. Can be an IP or URL."
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  nullable    = false
  description = "The API token for the service account in format: terraform@pve!provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "proxmox_ssh_username" {
  type        = string
  sensitive   = false
  nullable    = false
  description = "The SSH username to use to ssh into the proxmox server"
}

variable "proxmox_ssh_password" {
  type        = string
  sensitive   = true
  nullable    = false
  description = "The SSH password to use to ssh into the proxmox server"
}

variable "cloudflare_api_key" {
  type        = string
  sensitive   = true
  nullable    = false
  description = "The global Cloudflare API key"
}
