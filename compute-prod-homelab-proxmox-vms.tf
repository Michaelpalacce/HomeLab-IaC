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
  vm_boot_disk_size = 128
  vm_disks = [
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
      node_data         = data.proxmox_virtual_environment_node.prox-1.node_name
      cpu_cores         = 2
      cpu_sockets       = 1
      memory_dedicated  = 4000
      vm_boot_disk_size = 400
      cloud_image_url   = ""
    },
    "k3s-n1" = {
      node_data         = data.proxmox_virtual_environment_node.prox-1.node_name
      cpu_cores         = 3
      cpu_sockets       = 2
      memory_dedicated  = 24000
      vm_boot_disk_size = 400
      disk_size         = 440
      disk_datastore_id = "extra"
      cloud_image_url   = ""
    },
    "k3s-m2" = {
      node_data         = data.proxmox_virtual_environment_node.prox-2.node_name
      cpu_cores         = 2
      cpu_sockets       = 1
      memory_dedicated  = 4000
      vm_boot_disk_size = 64
      cloud_image_url   = ""
    },
    "k3s-n2" = {
      node_data         = data.proxmox_virtual_environment_node.prox-2.node_name
      cpu_cores         = 3
      cpu_sockets       = 2
      memory_dedicated  = 16000
      vm_boot_disk_size = 64
      disk_size         = 440
      disk_datastore_id = "extra"
      cloud_image_url   = ""
    },
    "k3s-m3" = {
      node_data         = data.proxmox_virtual_environment_node.prox-3.node_name
      cpu_cores         = 2
      cpu_sockets       = 1
      memory_dedicated  = 4000
      vm_boot_disk_size = 64
      cloud_image_url   = ""
    },
    "k3s-n3" = {
      node_data         = data.proxmox_virtual_environment_node.prox-3.node_name
      cpu_cores         = 3
      cpu_sockets       = 2
      memory_dedicated  = 16000
      vm_boot_disk_size = 64
      disk_size         = 430
      disk_datastore_id = "extra"
      cloud_image_url   = ""
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
  vm_boot_disk_size = each.value.vm_boot_disk_size
  vm_disks = (lookup(each.value, "disk_size", null) != null ? [{
    interface    = lookup(each.value, "disk_interface", "scsi1")        # Default interface for additional disk
    datastore_id = lookup(each.value, "disk_datastore_id", "local-lvm") # Provide a sensible default if not specified
    size         = each.value.disk_size
    # Optional attributes for additional disk (use lookups with defaults or omit if not needed)
    cache       = lookup(each.value, "disk_cache", "none")
    discard     = lookup(each.value, "disk_discard", "ignore")
    iothread    = lookup(each.value, "disk_iothread", false)
    import_from = lookup(each.value, "disk_import_from", null)
  }] : [])
}
