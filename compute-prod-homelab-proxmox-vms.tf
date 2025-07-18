# -------------------------------------------------------
# Manages Virtual Machines in Proxmox
# -------------------------------------------------------

module "k3s-n5" {
  source = "./modules/k3s-vm"

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name = "prox-5"
  vm_name   = "k3s-n5"
  vm_pass   = var.vm_pass
  vm_cpu = {
    cores   = 3
    sockets = 2
  }
  vm_memory = {
    dedicated = 16000
  }
  vm_disks = [
    {
      interface    = "scsi0"
      datastore_id = "local-lvm"
      cache        = "none"
      discard      = "ignore"
      size         = 128
      iothread     = true
    },
    {
      interface    = "scsi1"
      datastore_id = "local-lvm"
      cache        = "none"
      discard      = "ignore"
      size         = 256
      iothread     = true
    }
  ]
}
