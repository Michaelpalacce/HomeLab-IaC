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

module "k3s_vms" {
  source = "./modules/k3s-vm"
  for_each = {
    "k3s-m1" = {
      node_data          = data.proxmox_virtual_environment_node.prox-1.node_name
      cpu_cores          = 2
      cpu_sockets        = 1
      memory_dedicated   = 4000
      disk0_size         = 400
      disk1_size         = 220
      disk0_datastore_id = "local-lvm"
      disk1_datastore_id = "extra"
      cloud_image_url    = ""
    },
    "k3s-n1" = {
      node_data          = data.proxmox_virtual_environment_node.prox-1.node_name
      cpu_cores          = 3
      cpu_sockets        = 2
      memory_dedicated   = 24000
      disk0_size         = 400
      disk1_size         = 220
      disk0_datastore_id = "local-lvm"
      disk1_datastore_id = "extra"
      cloud_image_url    = ""
    },
    "k3s-m2" = {
      node_data          = data.proxmox_virtual_environment_node.prox-2.node_name
      cpu_cores          = 2
      cpu_sockets        = 1
      memory_dedicated   = 4000
      disk0_size         = 64
      disk1_size         = 220
      disk0_datastore_id = "local-lvm"
      disk1_datastore_id = "extra"
      cloud_image_url    = ""
    },
    "k3s-n2" = {
      node_data          = data.proxmox_virtual_environment_node.prox-2.node_name
      cpu_cores          = 3
      cpu_sockets        = 2
      memory_dedicated   = 16000
      disk0_size         = 64
      disk1_size         = 220
      disk0_datastore_id = "local-lvm"
      disk1_datastore_id = "extra"
      cloud_image_url    = ""
    },
    "k3s-m3" = {
      node_data          = data.proxmox_virtual_environment_node.prox-3.node_name
      cpu_cores          = 2
      cpu_sockets        = 1
      memory_dedicated   = 4000
      disk0_size         = 64
      disk1_size         = 220
      disk0_datastore_id = "local-lvm"
      disk1_datastore_id = "extra"
      cloud_image_url    = ""
    },
    "k3s-n3" = {
      node_data          = data.proxmox_virtual_environment_node.prox-3.node_name
      cpu_cores          = 3
      cpu_sockets        = 2
      memory_dedicated   = 16000
      disk0_size         = 64
      disk1_size         = 210
      disk0_datastore_id = "local-lvm"
      disk1_datastore_id = "extra"
      cloud_image_url    = ""
    },
  }


  cloud_image_url = each.value.cloud_image_url

  vm_name      = each.key
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name     = each.value.node_data
  vm_boot_order = ["scsi0"]
  vm_cpu = {
    cores   = each.value.cpu_cores
    sockets = each.value.cpu_sockets
  }
  vm_memory = {
    dedicated = each.value.memory_dedicated
  }
  vm_disks = [
    {
      interface    = "scsi0"
      datastore_id = each.value.disk0_datastore_id
      cache        = "none"
      discard      = "ignore"
      size         = each.value.disk0_size
    },
    {
      interface    = "scsi1"
      datastore_id = each.value.disk1_datastore_id
      cache        = "none"
      discard      = "ignore"
      size         = each.value.disk1_size
    }
  ]
}
