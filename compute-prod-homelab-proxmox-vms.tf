# -------------------------------------------------------
# Manages Virtual Machines in Proxmox
# -------------------------------------------------------

module "k3s-n5" {
  source = "./modules/k3s-vm"

  vm_name      = "k3s-n5"
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name = data.proxmox_virtual_environment_node.prox-5.node_name
  vm_cpu = {
    cores   = 4
    sockets = 2
  }
  vm_memory = {
    dedicated = 22000
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
