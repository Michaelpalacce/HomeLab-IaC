# -------------------------------------------------------
# Manages Virtual Machines in Proxmox
# These are existing machines. In the future, migration to cloud images should be done to make the whole cluster more uniform.
# -------------------------------------------------------

resource "proxmox_virtual_environment_vm" "k3s-m1" {
  name        = "k3s-m1"
  description = "Managed by Terraform"
  tags        = ["terraform"]

  node_name = "prox-1"
  vm_id     = 100

  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  # Don't migrate the VM, as it's using localdisk lvm
  migrate = false

  cpu {
    cores      = 3
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    sockets    = 1
    hotplugged = 0
    limit      = 0
  }

  memory {
    dedicated      = 6000
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }

  operating_system {
    type = "l26"
  }

  disk {
    interface    = "scsi0"
    datastore_id = "local-lvm"
    cache        = "none"
    discard      = "ignore"
    size         = 400
  }

  disk {
    datastore_id = "extra"
    interface    = "scsi1"
    cache        = "none"
    discard      = "ignore"
    size         = 220
  }
}

resource "proxmox_virtual_environment_vm" "k3s-n1" {
  name        = "k3s-n1"
  description = "Managed by Terraform"
  tags        = ["terraform"]

  node_name = "prox-1"
  vm_id     = 101

  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  # Don't migrate the VM, as it's using localdisk lvm
  migrate = false

  cpu {
    cores      = 3
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    sockets    = 2
    hotplugged = 0
    limit      = 0
  }

  memory {
    dedicated      = 22000
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }

  operating_system {
    type = "l26"
  }

  disk {
    interface    = "scsi0"
    datastore_id = "local-lvm"
    cache        = "none"
    discard      = "ignore"
    size         = 400
  }

  disk {
    datastore_id = "extra"
    interface    = "scsi1"
    cache        = "none"
    discard      = "ignore"
    size         = 220
  }
}

resource "proxmox_virtual_environment_vm" "k3s-m2" {
  name        = "k3s-m2"
  description = "Managed by Terraform"
  tags        = ["terraform"]

  node_name = "prox-2-stefangenov"
  vm_id     = 102

  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  # Don't migrate the VM, as it's using localdisk lvm
  migrate = false

  cpu {
    cores      = 3
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    sockets    = 1
    hotplugged = 0
    limit      = 0
  }

  memory {
    dedicated      = 6000
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }

  operating_system {
    type = "l26"
  }

  disk {
    interface    = "scsi0"
    datastore_id = "local-lvm"
    cache        = "none"
    discard      = "ignore"
    size         = 64
  }

  disk {
    datastore_id = "extra"
    interface    = "scsi1"
    cache        = "none"
    discard      = "ignore"
    size         = 220
  }
}

resource "proxmox_virtual_environment_vm" "k3s-n2" {
  name        = "k3s-n2"
  description = "Managed by Terraform"
  tags        = ["terraform"]

  node_name = "prox-2-stefangenov"
  vm_id     = 106

  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  # Don't migrate the VM, as it's using localdisk lvm
  migrate = false

  cpu {
    cores      = 3
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    sockets    = 2
    hotplugged = 0
    limit      = 0
  }

  memory {
    dedicated      = 14000
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }

  operating_system {
    type = "l26"
  }

  disk {
    interface    = "scsi0"
    datastore_id = "local-lvm"
    cache        = "none"
    discard      = "ignore"
    size         = 64
  }

  disk {
    datastore_id = "extra"
    interface    = "scsi1"
    cache        = "none"
    discard      = "ignore"
    size         = 220
  }
}

resource "proxmox_virtual_environment_vm" "k3s-m3" {
  name        = "k3s-m3"
  description = "Managed by Terraform"
  tags        = ["terraform"]

  node_name = "prox-3"
  vm_id     = 103

  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  # Don't migrate the VM, as it's using localdisk lvm
  migrate = false

  cpu {
    cores      = 3
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    sockets    = 1
    hotplugged = 0
    limit      = 0
  }

  memory {
    dedicated      = 6000
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }

  operating_system {
    type = "l26"
  }

  disk {
    interface    = "scsi0"
    datastore_id = "local-lvm"
    cache        = "none"
    discard      = "ignore"
    size         = 64
  }

  disk {
    datastore_id = "extra"
    interface    = "scsi1"
    cache        = "none"
    discard      = "ignore"
    size         = 220
  }
}

resource "proxmox_virtual_environment_vm" "k3s-n3" {
  name        = "k3s-n3"
  description = "Managed by Terraform"
  tags        = ["terraform"]

  node_name = "prox-3"
  vm_id     = 105

  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  # Don't migrate the VM, as it's using localdisk lvm
  migrate = false

  cpu {
    cores      = 3
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    sockets    = 2
    hotplugged = 0
    limit      = 0
  }

  memory {
    dedicated      = 14000
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }

  operating_system {
    type = "l26"
  }

  disk {
    interface    = "scsi0"
    datastore_id = "local-lvm"
    cache        = "none"
    discard      = "ignore"
    size         = 64
  }

  disk {
    datastore_id = "extra"
    interface    = "scsi1"
    cache        = "none"
    discard      = "ignore"
    size         = 210
  }
}

