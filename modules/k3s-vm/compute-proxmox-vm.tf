resource "proxmox_virtual_environment_vm" "k3s_vm" {
  name        = var.vm_name
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = var.node_name

  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  scsi_hardware   = "virtio-scsi-single"
  on_boot         = true
  keyboard_layout = "en-us"
  # Don't migrate the VM, as it's using localdisk lvm
  migrate = false
  agent {
    enabled = true
  }

  cpu {
    cores      = var.vm_cpu.cores
    type       = var.vm_cpu.type
    units      = var.vm_cpu.units
    flags      = var.vm_cpu.flags
    numa       = var.vm_cpu.numa
    sockets    = var.vm_cpu.sockets
    hotplugged = var.vm_cpu.hotplugged
    limit      = var.vm_cpu.limit
  }

  memory {
    dedicated      = var.vm_memory.dedicated
    floating       = var.vm_memory.floating
    keep_hugepages = var.vm_memory.keep_hugepages
    shared         = var.vm_memory.shared
  }

  operating_system {
    type = "l26"
  }

  network_device {
    bridge = "vmbr0"
    # This enables the firewall
    firewall = true
  }

  dynamic "tpm_state" {
    for_each = var.cloud_image_url == "" ? [] : [1]
    content {
      version = "v2.0"
    }
  }

  boot_order = var.vm_boot_order

  # --- CloudImage Disk ---
  # This is the cloud image disk for the cloud image that you specified. It's needed and will be discarded after initial run.
  dynamic "disk" {
    for_each = var.cloud_image_url == "" ? [] : [1]
    content {
      datastore_id = "nas"
      interface    = "virtio0"
      import_from  = proxmox_virtual_environment_download_file.ubuntu_cloud_image[0].id

      cache   = "none"
      discard = "on"
      size    = 20
    }
  }


  dynamic "disk" {
    for_each = var.vm_disks
    content {
      datastore_id = disk.value.datastore_id
      interface    = disk.value.interface
      size         = disk.value.size

      # `lookup` is for optional vars.
      import_from = lookup(disk.value, "import_from", null)
      cache       = lookup(disk.value, "cache", null)
      discard     = lookup(disk.value, "discard", null)
      iothread    = lookup(disk.value, "iothread", null)
    }
  }

  dynamic "initialization" {
    for_each = var.cloud_image_url == "" ? [] : [1]
    content {
      ip_config {
        ipv4 {
          address = "dhcp"
        }
      }

      user_data_file_id = proxmox_virtual_environment_file.k3s_cc[0].id
    }
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
