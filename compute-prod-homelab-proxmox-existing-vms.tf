resource "proxmox_virtual_environment_vm" "k3s_vms" {
  for_each = {
    "k3s-m1" : {
      node = data.proxmox_virtual_environment_node.prox-1.node_name,

      memory = 4000,

      cores   = 2,
      sockets = 1,

      disk0_size = 400,
      disk1_size = 220
    },
    "k3s-n1" : {
      node = data.proxmox_virtual_environment_node.prox-1.node_name,

      memory = 24000,

      cores   = 3,
      sockets = 2,

      disk0_size = 400,
      disk1_size = 220
    },
    "k3s-m2" : {
      node = data.proxmox_virtual_environment_node.prox-2.node_name,

      memory = 4000,

      cores   = 2,
      sockets = 1,

      disk0_size = 64,
      disk1_size = 220
    },
    "k3s-n2" : {
      node = data.proxmox_virtual_environment_node.prox-2.node_name,

      memory = 16000,

      cores   = 3,
      sockets = 2,

      disk0_size = 64,
      disk1_size = 220
    },
    "k3s-m3" : {
      node = data.proxmox_virtual_environment_node.prox-3.node_name,

      memory = 4000,

      cores   = 2,
      sockets = 1,

      disk0_size = 64,
      disk1_size = 220
    },
    "k3s-n3" : {
      node = data.proxmox_virtual_environment_node.prox-3.node_name,

      memory = 16000,

      cores   = 3,
      sockets = 2,

      disk0_size = 64,
      disk1_size = 210
    },
  }

  name        = each.key
  description = "Managed by Terraform"
  tags        = ["terraform"]

  node_name = each.value.node

  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  migrate         = false # Don't migrate the VM, as it's using localdisk lvm

  agent {
    enabled = true
  }

  cpu {
    cores      = each.value.cores
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    sockets    = each.value.sockets
    hotplugged = 0
    limit      = 0
  }

  memory {
    dedicated      = each.value.memory
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
    size         = each.value.disk0_size
  }

  disk {
    datastore_id = "extra"
    interface    = "scsi1"
    cache        = "none"
    discard      = "ignore"
    size         = each.value.disk1_size
  }

  lifecycle {
    ignore_changes = [
      ipv4_addresses,
      ipv6_addresses,
      mac_addresses,
      network_interface_names
    ]
  }
}
