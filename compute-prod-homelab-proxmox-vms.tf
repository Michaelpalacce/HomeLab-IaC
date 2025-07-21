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

module "k3s-m1" {
  source = "./modules/k3s-vm"

  # @TODO: In the future, when I need/want to rebuild my k3s cluster, I can merge the two definitions. For now this is acceptable.
  cloud_image_url = ""

  vm_name      = "k3s-m1"
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name     = data.proxmox_virtual_environment_node.prox-1.node_name
  vm_boot_order = ["scsi0"]
  vm_cpu = {
    cores   = 2
    sockets = 1
  }
  vm_memory = {
    dedicated = 4000
  }
  vm_disks = [
    {
      interface    = "scsi0"
      datastore_id = "local-lvm"
      cache        = "none"
      discard      = "ignore"
      size         = 400
    },
    {
      interface    = "scsi1"
      datastore_id = "extra"
      cache        = "none"
      discard      = "ignore"
      size         = 220
    }
  ]
}

module "k3s-n1" {
  source = "./modules/k3s-vm"

  # @TODO: In the future, when I need/want to rebuild my k3s cluster, I can merge the two definitions. For now this is acceptable.
  cloud_image_url = ""

  vm_name      = "k3s-n1"
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name     = data.proxmox_virtual_environment_node.prox-1.node_name
  vm_boot_order = ["scsi0"]
  vm_cpu = {
    cores   = 3
    sockets = 2
  }
  vm_memory = {
    dedicated = 24000
  }
  vm_disks = [
    {
      interface    = "scsi0"
      datastore_id = "local-lvm"
      cache        = "none"
      discard      = "ignore"
      size         = 400
    },
    {
      interface    = "scsi1"
      datastore_id = "extra"
      cache        = "none"
      discard      = "ignore"
      size         = 220
    }
  ]
}

module "k3s-m2" {
  source = "./modules/k3s-vm"

  # @TODO: In the future, when I need/want to rebuild my k3s cluster, I can merge the two definitions. For now this is acceptable.
  cloud_image_url = ""

  vm_name      = "k3s-m2"
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name     = data.proxmox_virtual_environment_node.prox-2.node_name
  vm_boot_order = ["scsi0"]
  vm_cpu = {
    cores   = 2
    sockets = 1
  }
  vm_memory = {
    dedicated = 4000
  }
  vm_disks = [
    {
      interface    = "scsi0"
      datastore_id = "local-lvm"
      cache        = "none"
      discard      = "ignore"
      size         = 64
    },
    {
      interface    = "scsi1"
      datastore_id = "extra"
      cache        = "none"
      discard      = "ignore"
      size         = 220
    }
  ]
}

module "k3s-n2" {
  source = "./modules/k3s-vm"

  # @TODO: In the future, when I need/want to rebuild my k3s cluster, I can merge the two definitions. For now this is acceptable.
  cloud_image_url = ""

  vm_name      = "k3s-n2"
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name     = data.proxmox_virtual_environment_node.prox-2.node_name
  vm_boot_order = ["scsi0"]
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
      size         = 64
    },
    {
      interface    = "scsi1"
      datastore_id = "extra"
      cache        = "none"
      discard      = "ignore"
      size         = 220
    }
  ]
}

module "k3s-m3" {
  source = "./modules/k3s-vm"

  # @TODO: In the future, when I need/want to rebuild my k3s cluster, I can merge the two definitions. For now this is acceptable.
  cloud_image_url = ""

  vm_name      = "k3s-m3"
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name     = data.proxmox_virtual_environment_node.prox-3.node_name
  vm_boot_order = ["scsi0"]
  vm_cpu = {
    cores   = 2
    sockets = 1
  }
  vm_memory = {
    dedicated = 4000
  }
  vm_disks = [
    {
      interface    = "scsi0"
      datastore_id = "local-lvm"
      cache        = "none"
      discard      = "ignore"
      size         = 64
    },
    {
      interface    = "scsi1"
      datastore_id = "extra"
      cache        = "none"
      discard      = "ignore"
      size         = 220
    }
  ]
}

module "k3s-n3" {
  source = "./modules/k3s-vm"

  # @TODO: In the future, when I need/want to rebuild my k3s cluster, I can merge the two definitions. For now this is acceptable.
  cloud_image_url = ""

  vm_name      = "k3s-n3"
  ssh_username = "stefan"
  ssh_passwrod = var.vm_pass

  proxmox_ssh_username = var.proxmox_ssh_username
  proxmox_ssh_password = var.proxmox_ssh_password
  proxmox_api_token    = var.proxmox_api_token
  proxmox_endpoint     = var.proxmox_endpoint

  node_name     = data.proxmox_virtual_environment_node.prox-3.node_name
  vm_boot_order = ["scsi0"]
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
      size         = 64
    },
    {
      interface    = "scsi1"
      datastore_id = "extra"
      cache        = "none"
      discard      = "ignore"
      size         = 210
    }
  ]
}
